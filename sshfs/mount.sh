mkdir -p /bulkinsert /opt/anaconda /home/akapliy
sudo sshfs -o allow_other root@bos-rndjob2:/bulkinsert /bulkinsert
sudo sshfs -o allow_other root@bos-rndjob2:/opt/anaconda /opt/anaconda
sudo sshfs -o allow_other root@bos-rndjob2:/home/akapliy /home/akapliy
