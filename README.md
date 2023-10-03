# PyEditorial

A free, open-source Blog CMS based on the "Django" and "Editorial" HTML5 theme.

---

### Example Deployment Fork

- Deployment uses Gunicorn, Nginx and PostgreSQL. Each running on its own container.
- Project has 2 environment files for configuration:
  - **.env:** t is used to configure web application. To connect external database, change POSTGRES_HOST and to change default user change DJANGO_SUPERUSER variables.
  - **.postgres.env:** It is used to configure Postgres database.

---

### Run with Docker (GNU/Linux and Mac)

1. Make sure that docker is installed

2. Go to project directory `cd PyEditorial`

3. Make local script executable `chmod +x ./local.sh`

4. Run `./local.sh`

5. Project should be available on `localhost` and test user (username: admin, password: admin) can be used.

6. To close the application, run `docker compose down`

---

### EC2 Deployment Steps

1. Deployment can change depending on the db type: Internal(Container) or External(RDS). If internal, development compose file can be used as a base. Otherwise, use `docker-compose.prod.yml`, it will not deploy a postgres container.

2. Provision an EC2 instance (i.e Ubuntu) with an User Data or SSH into the instance and execute commands manually.

Example User Data:

```
sudo snap install docker
git clone https://github.com/atakanatamert/PyEditorial.git
sudo docker compose build
sudo docker compose up -d
```

3. Deploy RDS instance and connect it to the EC2 instance. Make sure that security groups on both sides enable TCP communication on port 5432.

4. Modify the `.postgres.env` file. Make sure to include the appropriate host.

5. Create an application load balancer. Traffic will be served through that. Also attach an appropriate security group that enables https traffic/redirect http to https.

6. Make sure to enable http/https traffic to the instance security group. Source will be the ALB-SG.

7. Finally, attach hostname and certificate to the ALB. It can be done via Route 53 and ACM.

### Notes

- Currently it is not possible to deploy this project in ECS via Ubuntu images. The tasks will not run properly. Single container deployment can be a solution but it has its downsides. `Dockerfile.ecs.prod` can be a good starting point and any pr's to fix it are welcomed
