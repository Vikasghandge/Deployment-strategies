# Deployment stage and info 
```
apiVersion: apps/v1                  # API version for Deployment resource
kind: Deployment                     # Resource type (Deployment in this case)
metadata:                            # Metadata section for resource information
  name: nginx-deployment             # Unique name for the Deployment
  namespace: production              # Namespace where Deployment will be created
  labels:                            # To organize and select Deployments
    app: nginx                       # App label, useful for selectors
    version: v1.0                    # Version label for tracking releases
spec:                                # Desired state specification
  replicas: 3                        # Number of pod replicas to maintain
  selector:                          # How to select pods managed by this Deployment
    matchLabels:                     # Label selector configuration
      app: nginx                     # Pods must have this label to be managed
  template:                          # Pod template for creating replicas
    metadata:                        # Metadata for pods created by this Deployment
      labels:                        # Labels applied to created pods
        app: nginx                   # App label for pods (matches selector)
    spec:                            # Container specification
      containers:                    # List of containers in each pod
      - name: nginx                  # Container name
        image: nginx:1.21            # Docker image and version
        ports:                       # Ports exposed by the container
        - containerPort: 80          # Port the container listens on
        env:                         # Environment variables for configuration
        - name: ENV_VAR              # Environment variable name
          value: production-value    # Environment variable value
        resources:                   # Resource limits and requests
          limits:                    # Maximum resources allowed
            memory: "512Mi"          # Memory limit
            cpu: "1"                 # CPU limit
          requests:                  # Minimum resources requested
            memory: "256Mi"          # Memory request
            cpu: "250m"              # CPU request
        livenessProbe:               # Health check to restart unhealthy containers
          httpGet:                   # HTTP health endpoint
            path: /health            # Path for health check
            port: 80                 # Port for health check
          initialDelaySeconds: 30    # Wait before first check
          periodSeconds: 10          # Check interval
        readinessProbe:              # HTTP readiness check
          httpGet:                   # Readiness check endpoint
            path: /ready             # Path for readiness check
            port: 80                 # Port for readiness check
          initialDelaySeconds: 5     # Wait before first check
          periodSeconds: 5           # Check interval
        volumeMounts:                # Volumes mounted inside the container
        - name: config-volume        # Volume defined in "volumes" section
          mountPath: /etc/nginx/conf.d   # Mount point inside container
        - name: html-volume          # Mount as read-only
          mountPath: /usr/share/nginx/html # Mount point to web content
        - name: certs-volume
          mountPath: /etc/ssl/certs      # Mount point for certificates
        - name: secret-volume
          mountPath: /etc/nginx/secret   # Mount secret as volume
        - name: temp-volume
          mountPath: /tmp                # Mount as temp directory
      volumes:                        # Volumes available to all containers
      - name: config-volume
        configMap:                    # Use ConfigMap as volume source
          name: nginx-config          # Reference ConfigMap named "nginx-config"
      - name: secret-volume
        secret:                       # Use Secret as volume source
          secretName: nginx-secret    # Reference Secret named "nginx-secret"
      - name: html-volume
        persistentVolumeClaim:       # Persistent storage volume
          claimName: nginx-pvc        # Reference PVC named "nginx-pvc"
      - name: temp-volume
        emptyDir:                     # Temporary volume
          sizeLimit: 16Mi             # Size limit for temporary storage
```
