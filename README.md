# Resume-azure
My own resume hosted in azure ( cloud resume challenge)
will update soon

## Architecture
<img src=https://github.com/rghdrizzle/Resume-azure/blob/main/diagram.png>

## Cloud Resume Challenge
<p>This is a challenge where I build my resume on html and deploy it to the cloud with a proper workflow and cloud arhitecture. The Image above is the arhitecture of this challenge, we will be going through each process that I have been through and the challenges I have faced in this challenge.</p>

## Tools
<ul>
  <li>Azure functions</li>
  <li>Azure CDN</li>
  <li>Azure blob storage and Cosmos Db</li>
  <li>Terraform(IaC)</li>
  <li>Github Actions(CICD)</li>
</ul>

## Phase-1 (Building the Resume-Website)
<p>So the first phase was to build a resume static website using html and css. Since I didnt wanna spend too much time on desinging the resume website I used a template from the internet and altered the code depending on how I wanted it to look.</p>
![image](https://github.com/rghdrizzle/Resume-azure/assets/92255903/7603d7e2-cf9b-4a25-869f-fe8fc693d688)
This is the result of the staic resume page.

## Phase-2 (Hosting the website in azure)
This phase is all about deploying the static site to the cloud. In Azure we can achieve this by deploying the static site to a blob storage. Azure Blob storage has an option to configure it to host static websites. Once configured you can find a container named as $web. Now you can upload the website files directly from the portal or the cli. I personally chose to do it through the cli. The image below shows you the uploaded files for the static site in the blob storage
![image](https://github.com/rghdrizzle/Resume-azure/assets/92255903/95de4a72-b698-46c4-b4cb-01dfb0749bdd)
And you can access the static website through the primary endpoint given by azure for this particular site. [You can find it in the capabilites section in the overview of the Blob account and click "Static website" and find the primary and secondary endpoints]

