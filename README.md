# Final-ITI-Project

##  Infrastructure is created on aws using terraform.
### To run terraform infrastructre 
- terraform init
- terraform plan
- terraform apply

### Build jenkins image from docker file and push it to docker hub
```bash
docker build -t jenkins-img .
docker tag jenkins-img marwaahmed11/jenkins-img
docker images
docker push marwaahmed11/jenkins-img
```
![jenkins-img](https://user-images.githubusercontent.com/63955669/221412877-3c42bac7-a321-4fec-a7b1-095c85a0d52d.png)

### From your machine
1- Copy key on jump host to connect on private worker node 
```bash
scp -i final-key.pem final-key.pem ubuntu@44.203.72.128:/home/ubuntu
```
2- Copy file.sh on jump host to install kubectl and aws cli packages
```bash
scp -i final-key.pem file.sh ubuntu@44.203.72.128:/home/ubuntu
```
3- Copy yaml files on jump host
```bash
scp -i final-key.pem deployment.yaml ubuntu@44.203.72.128:/home/ubuntu
scp -i final-key.pem service.yaml ubuntu@44.203.72.128:/home/ubuntu
scp -i final-key.pem serviceAccount.yaml ubuntu@44.203.72.128:/home/ubuntu
scp -i final-key.pem volume.yaml ubuntu@44.203.72.128:/home/ubuntu
```
### From Jump host
1- Connect on on public ec2 (bastion host) 
```bash
ssh -i "final-key.pem" ubuntu@44.203.72.128
```
2- ssh on private worker node and install docker
```bash
ssh -i "final-key.pem" ec2-user@10.0.3.167
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl status docker
exit
```
3- Install kubectl and aws cli packages on jump host
```bash
sh file.sh
```
4- Configure aws on jump host
```bash
aws configure
```
5- Connect on aws cluster 
```bash
aws eks --region us-east-1 update-kubeconfig --name eks-cluster
kubectl get nodes
kubectl get svc 
```
6- Create an new namespace for jenkins
```bash
kubectl create namespace jenkins
kubectl apply -f volume.yaml -n jenkins
kubectl apply -f deployment.yaml -n jenkins
kubectl apply -f service.yaml -n jenkins
kubectl apply -f serviceAccount.yaml -n jenkins
kubectl get all -n jenkins
kubectl logs jenkins-7b586bdbcd-9dl9q -n jenkins
```
7- Add docker hub credentials and Create CI/CD pipeline 
![jenkins](https://user-images.githubusercontent.com/63955669/221414641-4f13c95f-02b4-4665-9b38-6db9e575f259.png)
![jump host ](https://user-images.githubusercontent.com/63955669/221414711-c86cb8e1-a0a2-43cb-a6c8-405ace56225a.png)
![image on docker hub](https://user-images.githubusercontent.com/63955669/221414727-702e7a25-95bf-4f68-8c24-034becbe73bd.png)
![load balancer](https://user-images.githubusercontent.com/63955669/221414729-08bb9f47-9c8b-44ca-9570-f6ec80cde041.png)


