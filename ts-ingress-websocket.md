---

copyright:
  years: 2014, 2023
lastupdated: "2023-01-30"

keywords: kubernetes, help, network, connectivity

subcollection: containers
content-type: troubleshoot

---

{{site.data.keyword.attribute-definition-list}}




# Why does a connection via WebSocket close after 60 seconds?
{: #cs_ingress_websocket}
{: support}

[Virtual Private Cloud]{: tag-vpc} [Classic infrastructure]{: tag-classic-inf}


Your Ingress service exposes an app that uses a WebSocket. However, the connection between a client and your WebSocket app closes when no traffic is sent between them for 60 seconds.
{: tsSymptoms}


The connection to your WebSocket app might drop after 60 seconds of inactivity for one of the following reasons:
{: tsCauses}

* Your Internet connection has a proxy or firewall that doesn't tolerate long connections.
* A timeout in the ALB to the WebSocket app terminates the connection.


To prevent the connection from closing after 60 seconds of inactivity:
{: tsResolve}

1. If you connect to your WebSocket app through a proxy or firewall, make sure the proxy or firewall isn't configured to automatically terminate long connections.

2. To keep the connection alive, you can increase the value of the timeout or set up a heartbeat in your app.
    * **Change the timeout**: Increase the value of the `proxy-read-timeout` in your ALB configuration. For example, to change the timeout from `60s` to a larger value like `300s`, add this [annotation](/docs/containers?topic=containers-comm-ingress-annotations#custom-connect-read-timeouts) to your Ingress resource file: `nginx.ingress.kubernetes.io/proxy-read-timeout: 300`. The timeout is changed for all public ALBs in your cluster.
    * **Set up a heartbeat**: If you don't want to change the ALB's default read timeout value, set up a heartbeat in your WebSocket app. When you set up a heartbeat protocol by using a framework like [WAMP](https://wamp-proto.org/){: external}, the app's upstream server periodically sends a "ping" message on a timed interval and the client responds with a "pong" message. Set the heartbeat interval to 58 seconds or less so that the "ping/pong" traffic keeps the connection open before the 60-second timeout is enforced.






