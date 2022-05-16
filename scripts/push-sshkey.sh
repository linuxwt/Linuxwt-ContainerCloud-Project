#host1=`cat /etc/ansible/hosts | awk -F " " '{print $1}' | grep '^10'`

host1=`cat /etc/ansible/hosts | awk -F " " '{print $1}' | grep '^10' | head -n 1`
for i in $host1;

do
    password="cmcc@123"
    /usr/bin/expect -c "
        spawn ssh-copy-id root@$i 
        expect {
        \"*(yes/no)\" {send \"yes\r\";exp_continue }
        \"*password\" { send \"$password\r\"; exp_continue }
        }     
expect eof"    
done   
