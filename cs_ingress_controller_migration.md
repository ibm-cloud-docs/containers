---

copyright:
  years: 2025, 2026
lastupdated: "2026-07-09"

keywords: ingress, traefik, migration, ingress-nginx, alb, ingress controller

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}

# Migrating from Ingress-NGINX to Traefik Ingress controller
{: #ingress-controller-migration}

Migrate your Ingress setup to use the Traefik controller instead of the Ingress-NGINX controller.
{: shortdesc}

## Before you begin
{: #ingress-controller-migration-prereqs}

Review these prerequisites before migrating.

1. Ensure you have the required permissions.
    - **Administrator** platform access role for the cluster
    - **Manager** service access role in all namespaces

1. Review existing Ingress resources for Ingress-NGINX specific annotations or configurations. Review the documentation on [the key differences between the two Ingress controllers](/docs/containers?topic=containers-managed-ingress-move-traefik).

1. Plan your migration strategy based on workload requirements, downtime tolerance, and resource availability. Both controllers can run simultaneously during the migration.

1. Ensure your cluster has at least two worker nodes per zone for high availability.

1. Back up your current Ingress configurations before making changes.

## Strategy 1: Separate Ingress setup with different domain
{: #separate}

Test Traefik with a separate setup while keeping production on Ingress-NGINX. This strategy provides maximum isolation and safety.

Use this strategy when:
- You want to thoroughly test Traefik before migrating production workloads.
- You can deploy a different set of applications for testing.
- You have the resources to run additional ALBs.
- You want zero risk to your production environment during testing.

### Steps
{: #separate-steps}

1. Get available Traefik versions.
    ```sh
    ibmcloud ks ingress alb versions
    ```
    {: pre}

1. Create a new ALB with Traefik.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb create classic --cluster <cluster_name> --type <public|private> --zone <zone> --vlan <vlan_id> --version <traefik_version>
    ```
    {: pre}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb create vpc-gen2 --cluster <cluster_name> --type <public|private> --zone <zone> --version <traefik_version>
    ```
    {: pre}

1. For VPC clusters, deploy an additional LoadBalancer Service manually for testing purposes. Set `spec.selector` to include `app.kubernetes.io/vpcComponent: public-cr<cluster_id>-traefik` (or `private-cr<cluster_id>-traefik` for private ALBs). On Classic clusters, a new load balancer is provisioned automatically and no additional configuration is required.

1. Create a custom domain for the Traefik ALB and point it to the load balancer's hostname or IP address. See [Creating custom domains](/docs/containers?topic=containers-managed-ingress-setup#ingress-custom-domain) for detailed instructions.

1. Create an Ingress resource for test applications using the Traefik Ingress class. Follow [Step 3: Create the Ingress resource](/docs/containers?topic=containers-managed-ingress-setup#managed-ingress-steps-resource), specifying `ingressClassName: public-iks-traefik` (or `private-iks-traefik` for private ALBs).

1. Test applications through the Traefik domain and verify functionality.

1. After testing, proceed to [Making the switch](#ingress-controller-migration-switch) to migrate your production workloads.

## Strategy 2: Dual load balancers with same workload
{: #dual}

Test both controllers on the same workload by creating two Ingress resources that point to the same service. You can directly compare controller behavior without affecting production traffic.

Use this strategy when:
- You want to compare Ingress-NGINX and Traefik behavior on the same workload.
- You need to validate that Traefik handles your specific application correctly.
- You can test using a non-production domain.
- You want to minimize the number of test applications needed.

### Steps
{: #dual-steps}

1. Enable a new ALB with a Traefik-based version.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb create classic --cluster <cluster_name> --type <public|private> --zone <zone> --vlan <vlan_id> --version <traefik_version>
    ```
    {: pre}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb create vpc-gen2 --cluster <cluster_name> --type <public|private> --zone <zone> --version <traefik_version>
    ```
    {: pre}

1. For VPC clusters, deploy an additional LoadBalancer Service manually for testing purposes. Set `spec.selector` to include `app.kubernetes.io/vpcComponent: public-cr<cluster_id>-traefik` (or `private-cr<cluster_id>-traefik` for private ALBs). On Classic clusters, a new load balancer is provisioned automatically and no additional configuration is required.

1. Create a custom domain for the Traefik ALB and point it to the load balancer's hostname or IP address. See [Creating custom domains](/docs/containers?topic=containers-managed-ingress-setup#ingress-custom-domain) for detailed instructions.

1. Create a second Ingress resource that uses the Traefik Ingress class but points to the same service as your existing Ingress-NGINX Ingress resource. Follow the instructions in [Step 3: Create the Ingress resource](/docs/containers?topic=containers-managed-ingress-setup#managed-ingress-steps-resource), making sure to:
    - Specify `ingressClassName: public-iks-traefik` (or `private-iks-traefik` for private ALBs)
    - Use the same `service.name` value that your existing Ingress-NGINX Ingress resource uses
    - Use your test domain in the `host` and `tls.hosts` fields

1. Test your application through both domains.
    - Access via the Ingress-NGINX domain (production)
    - Access via the Traefik domain (testing)

1. Compare behavior, performance, and functionality between the two controllers.

1. After validating, proceed to [Making the switch](#ingress-controller-migration-switch) to migrate your production domain to Traefik.

## Strategy 3: Split DNS testing
{: #split-dns}

Use a split-DNS setup to test Traefik with your production domain in a production-like environment without affecting your users.

Use this strategy when:
- You want to test with your actual production domain.
- You have control over DNS configuration for your test environment.
- You need to validate the exact production configuration.
- You want to minimize differences between test and production.

### Steps
{: #split-dns-steps}

1. Enable a new ALB with a Traefik-based version.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb create classic --cluster <cluster_name> --type <public|private> --zone <zone> --vlan <vlan_id> --version <traefik_version>
    ```
    {: pre}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb create vpc-gen2 --cluster <cluster_name> --type <public|private> --zone <zone> --version <traefik_version>
    ```
    {: pre}

1. For VPC clusters, deploy an additional LoadBalancer Service manually for testing purposes. Set `spec.selector` to include `app.kubernetes.io/vpcComponent: public-cr<cluster_id>-traefik` (or `private-cr<cluster_id>-traefik` for private ALBs). On Classic clusters, a new load balancer is provisioned automatically and no additional configuration is required.

1. Get the IP address (classic) or hostname (VPC) of the new Traefik ALB.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Configure split-DNS in your test environment.
    - For your test machines or network, configure DNS to resolve your production domain to the Traefik ALB IP/hostname
    - Production users continue to resolve to the Ingress-NGINX ALB
    - This can be done through local `/etc/hosts` files, internal DNS servers, or VPN-specific DNS configurations

1. Create a new Ingress resource using the Traefik Ingress class with your production domain. Follow [Step 3: Create the Ingress resource](/docs/containers?topic=containers-managed-ingress-setup#managed-ingress-steps-resource), specifying `ingressClassName: public-iks-traefik` (or `private-iks-traefik` for private ALBs) and your production domain in the `host` and `tls.hosts` fields.

1. Test from your split-DNS environment to validate Traefik with the production domain and configuration.

1. After validating, proceed to [Making the switch](#ingress-controller-migration-switch) to update production DNS to point to Traefik.

## Strategy 4: Direct migration
{: #direct-migration}

Directly switch from Ingress-NGINX to Traefik with minimal configuration changes and resource management.

This strategy causes service disruption during the migration. Plan for a maintenance window before you begin.
{: important}

Use this strategy when:
- You have a small workload or non-critical applications.
- You can tolerate brief downtime during the migration.
- You want to minimize the number of resources to manage.
- You have already validated Traefik compatibility in another environment.
- On Classic, you must keep the IP addresses of your ALBs unchanged because your clients connect using IP addresses instead of DNS domains.

Disabling and re-enabling an ALB preserves its original IP address, unless that IP address has been picked up by other services in the meantime. For more information, see [Enabling or disabling ALBs](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).
{: note}

### Steps
{: #direct-migration-steps}

1. Get the ID of your current Ingress-NGINX ALB.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Disable the Ingress-NGINX ALB.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb disable classic --alb <alb_id> --cluster <cluster_name>
    ```
    {: pre}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb disable vpc-gen2 --alb <alb_id> --cluster <cluster_name>
    ```
    {: pre}

1. Enable the ALB with a Traefik version.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb enable classic --alb <alb_id> --version <traefik_version> --cluster <cluster_name>
    ```
    {: pre}

    To use a specific IP address for the ALB on classic, use the `--ip` flag. For more information, see [Enabling or disabling ALBs](/docs/containers?topic=containers-kubernetes-service-cli#cs_alb_configure).
    {: note}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb enable vpc-gen2 --alb <alb_id> --version <traefik_version> --cluster <cluster_name>
    ```
    {: pre}

1. For VPC clusters, set the load balancer backend to Traefik.

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress load-balancer backend set --cluster <cluster-id> --public-backend traefik [--private-backend traefik]
    ```
    {: pre}

1. Update your Ingress resources to use the Traefik Ingress class. If your resources explicitly set the Ingress class, update `spec.ingressClassName` from `public-iks-k8s-nginx` to `public-iks-traefik` (or from `private-iks-k8s-nginx` to `private-iks-traefik` for private ALBs).

1. Apply the updated Ingress resources.
    ```sh
    kubectl apply -f ingress.yaml
    ```
    {: pre}

1. Verify that your applications are accessible through the Traefik controller.
    ```sh
    curl https://<domain>/<app_path>
    ```
    {: pre}

## Making the switch to Traefik
{: #ingress-controller-migration-switch}

After testing, switch production traffic to use the Traefik controller. The steps differ between classic and VPC clusters. Choose the option that matches your cluster type and setup.

### Classic clusters
{: #switch-classic}

For classic clusters, update your production domain to point to the load balancer that exposes Traefik instead of Ingress-NGINX.

#### Option 1: Update the domain mapping
{: #switch-mapping}

1. Get the IP address of your Traefik ALB.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Update your domain to point to the Traefik ALB.
    ```sh
    ibmcloud ks ingress domain update --cluster <cluster_name> --domain <domain_name> --ip <traefik_alb_ip>
    ```
    {: pre}

1. Verify the domain update.
    ```sh
    ibmcloud ks ingress domain ls --cluster <cluster_name>
    ```
    {: pre}

1. Test your applications through the production domain to ensure they are now served by Traefik.

#### Option 2: Disable Ingress-NGINX ALBs
{: #switch-disable}

Alternatively, you can disable all Ingress-NGINX based ALBs, which automatically updates the domain mappings.

1. List all ALBs and identify the Ingress-NGINX based ones.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Disable each Ingress-NGINX ALB.
    ```sh
    ibmcloud ks ingress alb disable classic --alb <nginx_alb_id> --cluster <cluster_name>
    ```
    {: pre}

1. Verify that your domain now points to the Traefik ALBs.
    ```sh
    ibmcloud ks ingress domain ls --cluster <cluster_name>
    ```
    {: pre}

#### Option 3: Preserve ALB IP addresses
{: #switch-preserve-ip}

If your clients connect directly to ALB IP addresses rather than DNS names, you can preserve those IP addresses during migration. Preserving IP addresses requires temporarily disabling ALBs, which causes brief service disruption.

Disabling and re-enabling an ALB preserves its original IP address, unless that IP address has been picked up by other services.
{: note}

1. List all ALBs and identify the Ingress-NGINX based ones to get their IDs and IP addresses.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Disable the Ingress-NGINX ALB. This causes brief service disruption for traffic on that IP address.
    ```sh
    ibmcloud ks ingress alb disable classic --alb <alb_id> --cluster <cluster_name>
    ```
    {: pre}

1. Re-enable the ALB with a Traefik version to reuse the same IP address.
    ```sh
    ibmcloud ks ingress alb enable classic --alb <alb_id> --version <traefik_version> --cluster <cluster_name>
    ```
    {: pre}

    Alternatively, create a new ALB and use the `--ip` flag to reuse the original IP address.

1. Update your Ingress resources to use the Traefik Ingress class. If your resources explicitly set the Ingress class, update `spec.ingressClassName` from `public-iks-k8s-nginx` to `public-iks-traefik` (or from `private-iks-k8s-nginx` to `private-iks-traefik` for private ALBs).

1. Apply the updated Ingress resources.
    ```sh
    kubectl apply -f ingress.yaml
    ```
    {: pre}

1. Verify that your applications are accessible through the Traefik controller.
    ```sh
    curl https://<domain>/<app_path>
    ```
    {: pre}

### VPC clusters
{: #switch-vpc}

For VPC clusters, update the load balancer backend to expose Traefik instead of Ingress-NGINX.

#### Option 1: Update the load balancer backend
{: #switch-lb-backend}

1. Update the load balancer to use the Traefik backend.
    ```sh
    ibmcloud ks ingress load-balancer backend set --cluster <cluster_name> --public-backend traefik [--private-backend traefik]
    ```
    {: pre}

1. Verify the load balancer configuration.
    ```sh
    ibmcloud ks ingress load-balancer get --cluster <cluster_name>
    ```
    {: pre}

1. Test your applications to ensure they are now served by Traefik.

#### Option 2: Disable Ingress-NGINX ALBs
{: #switch-disable-albs}

Alternatively, you can disable all Ingress-NGINX based ALBs.

1. List all ALBs and identify the Ingress-NGINX based ones.
    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

1. Disable each Ingress-NGINX ALB.
    ```sh
    ibmcloud ks ingress alb disable vpc-gen2 --alb <nginx_alb_id> --cluster <cluster_name>
    ```
    {: pre}

1. Verify that the load balancer now uses the Traefik ALBs.
    ```sh
    ibmcloud ks ingress load-balancer get --cluster <cluster_name>
    ```
    {: pre}

## Post-migration tasks
{: #post}

After migrating to Traefik, complete the following tasks:

1. Monitor your applications for any unexpected behavior or errors after the migration.

1. Update internal documentation to reflect the new Ingress setup with Traefik.

1. Remove any test ALBs, domains, or Ingress resources that are no longer needed.

1. After confirming that Traefik works as expected, disable remaining Ingress-NGINX ALBs.

    [Classic clusters]{: tag-classic-inf}
    ```sh
    ibmcloud ks ingress alb disable classic --alb <nginx_alb_id> --cluster <cluster_name>
    ```
    {: pre}

    [VPC clusters]{: tag-vpc}
    ```sh
    ibmcloud ks ingress alb disable vpc-gen2 --alb <nginx_alb_id> --cluster <cluster_name>
    ```
    {: pre}

## Troubleshooting
{: #ingress-controller-migration-troubleshooting}

If you encounter issues during or after migration, use the following steps to diagnose and resolve them.

Check Ingress class
:   Verify that Ingress resources use the correct Traefik class (`public-iks-traefik` or `private-iks-traefik`).

Verify ALB status
:   Ensure your Traefik ALBs are in a healthy state.

    ```sh
    ibmcloud ks ingress alb ls --cluster <cluster_name>
    ```
    {: pre}

Check Ingress status
:   Review the status of your Ingress resources.

    ```sh
    kubectl get ingress -A
    ```
    {: pre}

Review logs
:   Check the Traefik controller logs for errors.

    ```sh
    kubectl logs -n kube-system -l alb-image-type=traefik
    ```
    {: pre}

Run diagnostics
:   Use the Ingress status report to identify issues.

    ```sh
    ibmcloud ks ingress status-report get --cluster <cluster_name>
    ```
    {: pre}

Roll back if needed
:   If you encounter critical issues, roll back to Ingress-NGINX by disabling the Traefik ALB and re-enabling the Ingress-NGINX ALB with its original version. Plan to resolve the issues and migrate again.

For additional help, see [Troubleshooting Ingress](/docs/containers?topic=containers-ingress-debug) or contact [{{site.data.keyword.cloud_notm}} Support](https://cloud.ibm.com/unifiedsupport/supportcenter){: external}.
