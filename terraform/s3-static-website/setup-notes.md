# command for execute shell inside jenkins to sync s3 bucket with jenkins workspace
aws s3 sync /var/lib/jenkins/workspace/resume-website/website/ s3://angpenghian-s3/