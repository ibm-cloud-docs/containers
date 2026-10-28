---

copyright:
  years: 2026, 2026
lastupdated: "2026-10-28"

keywords: kubernetes, classic, vpc, migrate, migration, ingress, ALB, custom ALB, NGINX, Traefik, public-iks-traefik, private-iks-traefik

subcollection: containers

content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}

# Why do migrated custom ALBs use NGINX instead of Traefik?
{: #ts-migrate-alb-traefik}
{: troubleshoot}
{: support}

[Virtual Private Cloud]{: tag-vpc}

After you migrate a Classic cluster to VPC, the default Ingress application load balancers (ALBs) run Traefik, but the custom ALBs that were carried over from the Classic cluster still run NGINX.
{: shortdesc}

After migration, your VPC cluster is in a mixed state. When you list the ALBs, the default ALBs run a Traefik version (`3.X.X_XXXX_iks`), while custom ALBs run an NGINX version (`0.X.X_XXXX_iks` or `1.X.X_XXXX_iks`, for example `1.15.10_373802345_iks`).
{: tsSymptoms}

Default ALBs in VPC clusters are provisioned with Traefik. Custom ALBs that were migrated from the Classic cluster continue to run NGINX build images.
{: tsCauses}

In a VPC cluster, each public and each private ALB has a single host, so the ALBs can point directly to their respective Traefik instances. To resolve the issue, replace the NGINX build image of each custom ALB with a Traefik build image. Then, update your Ingress resources to use the Traefik Ingress classes.
{: tsResolve}

1. List the available ALB versions and note the latest Traefik version (format `3.X.X_XXXX_iks`) from the `supportedTraefikVersions` list or `defaultTraefikVersion`. You can optionally specify the `--region` flag to check a specific region.

   ```sh
   ibmcloud ks ingress alb versions --output json
   ```
   {: pre}

   Example output:
   ```json
   {
       "defaultK8sVersion": "1.15.10_379572403_iks",
       "defaultTraefikVersion": "3.7.13_379020891_iks",
       "supportedK8sVersions": [
           "1.15.10_379572403_iks"
       ],
       "k8sStatus": "ga",
       "supportedTraefikVersions": [
           "3.7.12_379572444_iks",
           "3.7.13_379020891_iks",
           "3.7.14_379840236_iks"
       ],
       "traefikStatus": "ga"
   }
   ```
   {: screen}

2. List the ALBs in your cluster and identify the ones that run an NGINX version. Check both public and private ALBs.

   ```sh
   ibmcloud ks ingress alb ls --cluster CLUSTER_NAME_OR_ID
   ```
   {: pre}

   In the CLI output, check the **Build** column. ALBs with a build version that starts with `0.` or `1.` run NGINX. ALBs with a version that starts with `3.` run Traefik.

   Alternatively, you can review ALB versions and health in the console:
   1. From the [{{site.data.keyword.containerlong_notm}} clusters console](https://cloud.ibm.com/kubernetes/clusters){: external}, select your VPC cluster.
   2. In the navigation menu, select **Ingress**.
   3. Select the **Ingress Controllers (ALB)** tab.
   4. In the table, review the **Build**, **Status**, and **Type** columns. ALBs running NGINX display a **Build** version starting with `0.` or `1.` (for example `1.15.10_373802345_iks`) and might show a **Warning** status. ALBs running Traefik display a **Build** version starting with `3.` (for example `3.7.13_379020891_iks`) and show a **Healthy** status.

3. Disable each ALB that runs NGINX. Repeat this step for each NGINX ALB.

   ```sh
   ibmcloud ks ingress alb disable --alb ALB_ID --cluster CLUSTER_NAME_OR_ID
   ```
   {: pre}

4. Re-enable the ALB with the Traefik build image. Replace `TRAEFIK_VERSION` with the latest `3.X.X_XXXX_iks` version from step 1. Repeat this step for each ALB that you disabled.

   ```sh
   ibmcloud ks ingress alb enable vpc-gen2 --alb ALB_ID --cluster CLUSTER_NAME_OR_ID --version TRAEFIK_VERSION
   ```
   {: pre}

5. After the ALBs report as healthy, verify that the load balancer backend points to Traefik.

   ```sh
   ibmcloud ks ingress load-balancer get --cluster CLUSTER_NAME_OR_ID --output json
   ```
   {: pre}

   Example output when both public and private ALBs are enabled:
   ```json
   {
       "cluster": "db365cm209tmvo64q6g0",
       "backend": {
           "private": "traefik",
           "public": "traefik"
       }
   }
   ```
   {: screen}

   Example output when only the public ALB is enabled:
   ```json
   {
       "cluster": "db365cm209tmvo64q6g0",
       "backend": {
           "public": "traefik"
       }
   }
   ```
   {: screen}

6. Verify that all ALBs in the cluster run a Traefik version. If they do, update the `ingressClassName` in all Ingress resources across all namespaces that don't already use a Traefik Ingress class. For namespace-scoped Ingress resources, you must specify the class explicitly.
   * For public Ingress, use `public-iks-traefik`.
   * For private Ingress, use `private-iks-traefik`.

For more information about Ingress classes, see [Ingress class](/docs/containers?topic=containers-managed-traefik-ingress-about#traefik-managed-ingress-class).
