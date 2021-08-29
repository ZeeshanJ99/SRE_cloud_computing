# SRE introduction 
## Cloud Computing with AWS
### SDLC stages
#### Risk factors with SDLC stages
##### Monitoring

### Key Advantages:
- Ease of use
- Flexibility
- Robustness
- Cost

**SRE introduction**
- What is the role of SRE?
The role of an SRE is to create a bridge between devops through applying a CICD mindset. 
They can ensure that projects develop and evolve smoothly from start to finish.
SREs need to understand the resilience measures of their service and know when those measures will be insufficient at a future point of time and will need maintenance. 


**Cloud Computing**
- What is Cloud Computing and the benefits of using it?

Cloud computing is the delivery of different services through the Internet, including data storage, servers, databases, networking, and software. 
Cloud-based storage makes it possible to save files to a remote database and retrieve them on demand
The benefits include cost saving - easy access saves money and time in project startups, security- 94% of businesses saw an improvement in security (rapid scale) also dont need to employ your own security, mobility- by relying on an outside organisation you have more time to focus upon other parts of the business, insight - is able to provide information about users. scale on demand - cost effective. 


**What is Amazon Web Services (AWS)**
- What is AWS and benefits of using it

AWS is the worlds most comprehensive cloud platform that includes a mixture of infrastructure as a service (IaaS), platform as a service (PaaS) and packaged software as a service (SaaS) offerings.
AWS can be used to store critical data. It offers multiple types of storage to choose from, allowing businesses to make their own decisions based on their needs.

**What is SDLC and stages of SDLC**
- What is SDLC and what are the stages of it

Software Development Life Cycle is a process for planning, creating, testing and deploying an information system
The seven new stages: planning, analysis, design, development, testing, implementation, and maintenance.

![image](https://user-images.githubusercontent.com/88186084/130949727-d4387c63-bb70-42dd-816f-ba1a667e8e90.png)


**What are the Risk level at each stage of SDLC?**

- LOW - planning, analysis, design
- Medium- development, testing
- High - implementation, maintenence

----------------------------------------------

## What is On prem, Cloud, Hybrid cloud and multi cloud

- On prem - On prem means on premises data centres which allow you to have full control of your infrastructure. All data is in house and stored locally.
- Cloud - is in regards to data which is is hosted on a vendor's server (such as AWS) and accessed via a web browser. 

![image](https://user-images.githubusercontent.com/88186084/130950489-8fafea75-c7a8-47aa-9d27-0d1958d0d05a.png)

- Hybrid Cloud - Using the example of a bank which hosts public data such as how to apply for a loan or a mortgage as well as ultra confidential data such as bank pin numbers etc. a system is needed in order to host both. Usually this is known as Hybrid Cloud. The public data is stored upon the public cloud service whereas the confidential is stored on prem - as the bank is responsible for it. It is a combination of a public and a private cloud.

Netflix use hybrid cloud data storage due to its on-demand and pay-per-use features. and due to spikes in bandwidth demand when a new series debuts.

Also AWS came up with Gov Cloud - a secure cloud service that one can only use if they are a part of the government. As a member of the public access to Gov cloud is denied and is only available for select agencies. For example, CIA and NASA use this service.


- Multi Cloud
Multi-cloud entails multiple cloud services from one or more providers, for example AWS for application workloads and Microsoft Azure for enterprise database. 92 % of companies use a multi cloud system as it provides for a flexible approach - one cloud system could cater for a certain part of your business better than another. Also it helps to reduce poor response times for cloud users, some workloads could be hosted by regional cloud providers that operate closer to where the users are. This solution lets the enterprise maintain high availability and adhere to data sovereignty laws—protocols that subject data to the regulations of the country in which that data is located. This strategy is also cost-effective, where the competitive market strives to offer optimal pricing for different resource capacities. 


![image](https://user-images.githubusercontent.com/88186084/130951730-f24fbf95-0b73-4588-976f-70a498c1e56b.png)




- install nodejs
- install npm
- install pm2
- npm start

----------------------------------------------------------

## Automate provisioning and synced app folder

In provision.sh file add:
            
    !#/bin/bash

    sudo apt-get update -y

    sudo apt-get upgrade -y

    sudo apt-get install nginx -y


In the Vagrantfile add:

    
    Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.network "private_network", ip: "192.168.10.100"
    
    # Synced app folder
    config.vm.synced_folder "app", "/app"

    # Provisioning
    config.vm.provision "shell", path: "provision.sh", privileged: false

    end

- Run `vagrant up`
- Type in the browswer `192.168.10.100` this should connect to the nginx page on your web browser.

------------------------------------------

## Install dependencies for the node app

Installing nodejs sudo `apt-get install nodejs -y`

Ensure to install correct version:

    sudo apt-get install python-software-properties
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install nodejs -y



- Install pm2 - `sudo npm install pm2 -g`

- Ensure to run this inside the app folder - install npm `npm install`

- Launch the app `npm start`


- Put `192.168.10.100:3000` into the browser should go to the Sparta Global app




-------------------------------
## Multi-machine task with reverse proxy

- in app
`sudo nano /etc/nginx/sites-available/default`

replace the location in the file, you can replace the port code 8080 to whatever you need it to be, e.g. 3000

    server {
    listen 80;

    server_name _;

    location / {
        proxy_pass http://localhost:3000;      
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade'; 
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;      
    }
            }

            
- `sudo nginx -t`
- `sudo systemctl restart nginx`
- restart the node app from the app location
- `npm start`
- check your browser without the port 3000            


## If mongodb is installed
- in db
`sudo nano /etc/mongod.conf`
ip `127.0.0.1` change to `0.0.0.0`

- restart mongo
- enable mongo
- check status

--------------------------------------------------------------
## If it isnt installed this is how to set up mongo db
- be careful of these keys, they will go out of date
            
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
            echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

            sudo apt-get update -y
            sudo apt-get upgrade -y

- sudo apt-get install mongodb-org=3.2.20 -y

            sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

change the mongod.conf ip to `0.0.0.0`

- back to app VM to create the env var export `DB_HOST=db-ip/posts`
            
            export DB_HOST=192.168.10.150:27017/posts

            echo "export DB_HOST=192.168.10.150:27017/posts" >> ~/.bashrc

            source ~/.bashrc
            
- cd into the app folder
- sudo npm start
- go to 192.168.10.100/posts on the web browser
