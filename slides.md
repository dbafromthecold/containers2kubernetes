# Containers to Kubernetes

---

## Andrew Pruski

<img src="images/apruski.jpg" style="float: right"/>

### Principal Field Solutions Architect
#### Microsoft Data Platform MVP
#### Docker Captain
#### VMware vExpert

<!-- .slide: style="text-align: left;"> -->
<i class="fa-brands fa-bluesky"></i><a href="https://bsky.app/profile/dbafromthecold.com">  @dbafromthecold.com</a><br>
<i class="fas fa-envelope"></i>  dbafromthecold@gmail.com<br>
<i class="fab fa-wordpress"></i>  www.dbafromthecold.com<br>
<i class="fab fa-github"></i><a href="https://github.com/dbafromthecold">  github.com/dbafromthecold</a>

---

# Containers

---

## Agenda
<!-- .slide: style="text-align: left;"> -->
- Isolation<br>
- Networking<br>
- Persisting data<br>
- Custom images<br>
- Docker Compose<br>

---

# Isolation

---

## Container Isolation
<!-- .slide: style="text-align: left;"> -->
"Containers isolate software from its environment and ensure that it works uniformly despite differences for instance between development and staging"<br>
<font size="6"><a href="https://www.docker.com/resources/what-container">docker.com/resources/what-container</a></font>

---

## Control Groups
<!-- .slide: style="text-align: left;"> -->
Ensures a single container cannot consume all<br>
resources of the host<br>
<br>
Implements resource limiting of:-
- CPU
- Memory

---

## Namespaces
<!-- .slide: style="text-align: left;"> -->
Control what a container can see<br>
<br>
Used to control:-<br>
- Hostname within the container
- Processes that the container can see
- Mapping users in the container to users on the host

---

## File system
<!-- .slide: style="text-align: left;"> -->
- Containers cannot see the entire host's filesystem<br>
- They can only see a subset of that filesystem<br>
- The container root directory is changed

---

# Demo

---

# Networking

---

## Default networks
<!-- .slide: style="text-align: left;"> -->
<img src="images/docker_default_networks.png" style="float: right"/>

- bridge<br>
- host<br>
- none<br>

---

## Bridge network
<!-- .slide: style="text-align: left;"> -->
- Default network<br>
- Represents _docker0_ network<br>
- Containers communicate by IP address<br>
- Supports port mapping 

---

## User defined networks
<!-- .slide: style="text-align: left;"> -->
- Docker provide multiple drivers<br>
- DNS resolution of container names to IP addresses<br>
- Can be connected to more than one network<br>
- Connect/disconnect from networks without restarting<br>

---

# Demo

---

# Persisting data

---

## Options for persisting data
<!-- .slide: style="text-align: left;"> -->
- Bind mounts<br>
- Data volume containers<br>
- Named volumes

---

# Demo

---

# Custom images

---

## Building your own image
<!-- .slide: style="text-align: left;"> -->
- Custom images built from a file<br>
- Known as a dockerfile<br>
- Customise the image to grant permissions<br>
- Add databases to SQL Server<br>

---

## Dockerfile

<pre><code data-line-numbers="1|3|5-8|10|12|14">FROM mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04

USER root

RUN mkdir /var/opt/sqlserver
RUN mkdir /var/opt/sqlserver/sqldata
RUN mkdir /var/opt/sqlserver/sqllog
RUN mkdir /var/opt/sqlserver/sqlbackups

RUN chown -R mssql /var/opt/sqlserver

USER mssql

CMD /opt/mssql/bin/sqlservr
</pre></code>

---

# Demo

---

# Docker Compose

---

## Docker container run

<pre><code data-line-numbers="1|2|3-8|9|10-13|14|15">docker container run -d
--publish 15789:1433
--env SA_PASSWORD=Testing1122
--env ACCEPT_EULA=Y
--env MSSQL_AGENT_ENABLED=True
--env MSSQL_DATA_DIR=/var/opt/sqlserver/sqldata
--env MSSQL_LOG_DIR=/var/opt/sqlserver/sqllog
--env MSSQL_BACKUP_DIR=/var/opt/sqlserver/sqlbackups
--network sqlserver
--volume sqlsystem:/var/opt/mssql
--volume sqldata:/var/opt/sqlserver/sqldata
--volume sqllog:/var/opt/sqlserver/sqllog
--volume sqlbackup:/var/opt/sqlserver/sqlbackups
--name sqlcontainer1
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04
</pre></code>

---

## What is Compose?
<!-- .slide: style="text-align: left;"> -->
"Compose is a tool for defining and running multi-container Docker applications.
With Compose, you use a YAML file to configure your application`s services.
Then, with a single command, you create and start all the services from your configuration."<br>
<font size="6"><a href="https://docs.docker.com/compose/">docs.docker.com/compose</a></font>

---

# Demo

---

# Kubernetes

---

# Kubernetes Nodes
<!-- .slide: style="text-align: left;"> -->

---

### Node Types
<!-- .slide: style="text-align: left;"> -->

Two different types of Kubernetes nodes: -

<div style="display: flex; justify-content: center;">
  <div style="text-align: center;">
    <p>
      Control Nodes
    </p>
    <img src="images/control-256.png" />
  </div>
  <div style="width: 200px;"></div> <!-- Adjust the width to control the spacing -->
  <div style="text-align: center;">
    <p>
      Worker Nodes
    </p>
    <img src="images/node-256.png" />
  </div>
</div>

---

# Control Nodes
<!-- .slide: style="text-align: left;"> -->

---

### Control Node
<!-- .slide: style="text-align: left;"> -->
<img src="images/control-node.gif" style="float: right"/>

---

### Control Node Components
<!-- .slide: style="text-align: left;"> -->
<img src="images/control-256.png" style="float: right"/>

Managing the cluster: -
<ul>
  <li class="fragment">kube-apiserver</li>
  <li class="fragment">etcd</li>
  <li class="fragment">kube-scheduler</li>
  <li class="fragment">kube-controller-manager</li>
  <li class="fragment">cloud-controller-manager</li>
</ul>

---

### The API Server
<!-- .slide: style="text-align: left;"> -->
<img src="images/api-128.png" style="float: right"/>

RESTful API endpoint: -
- The control plane front end
- Authentication and Authorisation
- Validates incoming requests
- Manages lifecycle of Kubernetes resources

---

### ETCD
<!-- .slide: style="text-align: left;"> -->
<img src="images/etcd-128.png" style="float: right"/>

A distibuted key value store: -
- A consistent cluster view
- Persist cluster state
- High availability and scalability
- Backup and restore

---

### Kube-Scheduler
<!-- .slide: style="text-align: left;"> -->
<img src="images/sched-128.png" style="float: right"/>

Selects nodes to run pods: -
- Evaluates nodes in cluster
- Implements scheduling policies
- Resource allocation
- Load Balancing

---

### kube-controller-manager
<!-- .slide: style="text-align: left;"> -->
<img src="images/c-m-128.png" style="float: right"/>

Runs the controller processes: -
- Node controller
- Namespace Controller
- Service Controller
- StatefulSet Controller

---

### Control Node High Availability
<!-- .slide: style="text-align: left;"> -->
<img src="images/control_node_ha.png" style="float: right"/>

Control Plane HA is a must!
- Multiple control nodes
- Load balancing across nodes
- Etcd cluster
- Managed K8s clusters

---

# Worker Nodes

---

### Worker Node Components
<!-- .slide: style="text-align: left;"> -->
<img src="images/node-256.png" style="float: right"/>

Running applications: -
<ul>
  <li class="fragment">kube-proxy</li>
  <li class="fragment">kubelet</li>
  <li class="fragment">container runtime</li>
</ul>

---

### Kube-proxy
<!-- .slide: style="text-align: left;"> -->
<img src="images/k-proxy-128.png" style="float: right"/>

Maintains network rules on nodes: -
- Communication between pods and services
- Service discovery
- Endpoint monitoring
- Uses IP tables (or IPVS)

---

### Kubelet
<!-- .slide: style="text-align: left;"> -->
<img src="images/kubelet-128.png" style="float: right"/>

Lifecycle management of pods: -
- Interacts with the container runtime
- Monitors node utilisation
- Containers are running and healthy

---

### Container Runtime
<!-- .slide: style="text-align: left;"> -->
<img src="images/docker.png" style="float: right"/>

Interacts with the kubelet to: -
- Manage the lifecycle of containers
- Pull images from registry
- Provides isolation
- Used to be Docker

---

### Why no longer Docker?
<!-- .slide: style="text-align: left;"> -->
<img src="images/cross_docker.png" style="float: left; border: 20px solid rgba(0, 0, 0, 0);"/>
<br>

- Docker support hardcoded
- Added support for other runtimes
- Implementation of the CRI
- Dockershim no longer needed

---

# Demo
<!-- .slide: style="text-align: left;"> -->

---

# Deploying Applications
<!-- .slide: style="text-align: left;"> -->

---

### Daemonsets
<!-- .slide: style="text-align: left;"> -->

Runs a pod on every node in the cluster: -
- Log collection
- Monitoring
- Not really a use case for SQL Server!

---

### Deployments
<!-- .slide: style="text-align: left;"> -->

Declarative method to spin up applications: -
- Desired state in yaml file
- Self-healing
- Easy updates and rollbacks
- Typically for stateless apps

---

### Statefulsets
<!-- .slide: style="text-align: left;"> -->

Valuable for applications requiring: -
- Unique network identifiers
- Persistent storage
- Graceful deployment and scaling
- Ordered rolling updates

---

# Demo
<!-- .slide: style="text-align: left;"> -->

---

# Controlling high availability
<!-- .slide: style="text-align: left;"> -->

---

### Pod Eviction Timings

<pre><code data-line-numbers="1-9|2-5|6-9">tolerations:
- key: "node.kubernetes.io/unreachable"
  operator: "Exists"
  effect: "NoExecute"
  tolerationSeconds: 10
- key: "node.kubernetes.io/not-ready"
  operator: "Exists"
  effect: "NoExecute"
  tolerationSeconds: 10
</pre></code>

---

# Persisting Data
<!-- .slide: style="text-align: left;"> -->

---

### Persisting Data
<!-- .slide: style="text-align: left;"> -->

<div style="display: flex; justify-content: center;">
  <div style="text-align: center; flex-grow: 1; flex-basis: 0;">
    <p>
      Storage Classes
    </p>
    <img src="images/sc-128.png" />
  </div>
  <div style="text-align: center; flex-grow: 1; flex-basis: 0;">
    <p>
      Persistent Volumes
    </p>
    <img src="images/pv-128.png" />
  </div>
  <div style="text-align: center; flex-grow: 1; flex-basis: 0;">
    <p>
      Persistent Volume Claims
    </p>
    <img src="images/pvc-128.png" />
  </div>
</div>

---

# Demo
<!-- .slide: style="text-align: left;"> -->

---

### Resources
<!-- .slide: style="text-align: left;"> -->
<font size="6">
<a href="https://github.com/dbafromthecold/containers2kubernetes">https://github.com/dbafromthecold/containers2kubernetes</a><br>
</font>

<p align="center">
  <img src="images/QR" />
</p>
