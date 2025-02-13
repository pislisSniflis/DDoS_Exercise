# Cybersecurity Fundamentals Hands-On Lab Notes - DDoS Exercise
For PUO Students only. This testing and notes maybe vary than your institution. Understood! 

Below is a `docker-compose.yml` file to set up your environment for DDoS testing. It includes a target server (NGINX) and an attacker container (Kali Linux with pre-installed DDoS tools). Once you run the `docker-compose` command, it will automatically build and configure everything.

---

### **Directory Structure**
Before creating the `docker-compose.yml`, prepare the following directory structure:

```
ddos-lab/
├── docker-compose.yml
├── target/
│   ├── Dockerfile
│   └── index.html
└── attacker/
    └── Dockerfile
```

---

### **1. `docker-compose.yml`**
This file will define both the target and attacker containers and their configurations.

````artifact
id: DockerComposeDDoS
name: Docker Compose for DDoS Lab
type: code.yaml
content: |-
  version: '3.8'

  services:
    target:
      build:
        context: ./target
      ports:
        - "8080:80"
      networks:
        - ddos-net

    attacker:
      build:
        context: ./attacker
      stdin_open: true
      tty: true
      networks:
        - ddos-net

  networks:
    ddos-net:
      driver: bridge
````

---

### **2. Target Server (`target/Dockerfile`)**
This Dockerfile sets up an NGINX web server as the DDoS target.

````artifact
id: TargetServerDockerfile
name: Target Server Dockerfile
type: code.dockerfile
content: |-
  FROM nginx:latest
  COPY ./index.html /usr/share/nginx/html/index.html
  EXPOSE 80
````

---

### **3. Target Server HTML (`target/index.html`)**
This is a simple HTML file to simulate the web application.

````artifact
id: TargetServerIndex
name: Target Server Index
type: code.html
content: |-
  <!DOCTYPE html>
  <html>
  <head>
    <title>DDoS Test Target</title>
  </head>
  <body>
    <h1>Welcome to the DDoS Test Target</h1>
    <p>This is a simulated target for DDoS testing.</p>
  </body>
  </html>
````

---

### **4. Attacker Container (`attacker/Dockerfile`)**
This Dockerfile sets up a Kali Linux container with DDoS tools like `hping3` and `slowloris`.

````artifact
id: AttackerDockerfile
name: Attacker Dockerfile
type: code.dockerfile
content: |-
  FROM kalilinux/kali-rolling:latest
  RUN apt update && apt install -y hping3 slowloris
  CMD ["/bin/bash"]
````

---

### **5. Build and Run**
1. Navigate to the `ddos-lab` directory:
   ```bash
   cd ddos-lab
   ```

2. Build and start the environment using `docker-compose`:
   ```bash
   docker-compose up --build
   ```

3. Verify the services:
   - The target server will be available at `http://localhost:8080`.
   - The attacker container will be running in interactive mode. You can attach to it using:
     ```bash
     docker exec -it ddos-lab_attacker_1 bash
     ```

---

### **6. Simulate the DDoS Attack**
Once the environment is running:
1. **Inside the attacker container**, use tools like `hping3` or `slowloris`:
   - Example with `hping3`:
     ```bash
     hping3 -S -p 8080 --flood <target-ip>
     ```
   - Example with `slowloris`:
     ```bash
     slowloris <target-ip>
     ```

2. Monitor the traffic on the target server at `http://localhost:8080`.

---

### **7. Stop the Environment**
To stop the environment, use:
```bash
docker-compose down
```

---

This setup is self-contained and easy to deploy using `docker-compose`. Let me know if you'd like additional monitoring tools or enhancements!
