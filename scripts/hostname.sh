host2=$(cat /etc/ansible/hosts | awk '{print $1}' | grep '^192'  | head -n 4)

for p in $host2

do 
    n=$(cat /etc/hosts | grep $p | wc -l)
    if [ $n -eq 1 ];then
      m=$(cat /etc/hosts | grep $p | awk '{print $2}')
    else
      continue
    fi
    ssh $p "hostnamectl set-hostname $m"
done
