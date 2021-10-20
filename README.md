# roamlab
Repo for IaC for portable hardware lab

ubiquiti controller: https://192.168.8.106:8443/manage/default/dashboard

For Unifi to adopt other devices, e.g. an Access Point, it is required to change the inform IP address. Because Unifi runs inside Docker by default it uses an IP address not accessible by other devices. To change this go to Settings > System Settings > Controller Configuration and set the Controller Hostname/IP to a hostname or IP address accessible by your devices. Additionally the checkbox "Override inform host with controller hostname/IP" has to be checked, so that devices can connect to the controller during adoption (devices use the inform-endpoint during adoption).

pihole: http://192.168.8.106/admin

prometheus: http://192.168.8.106:9090/graph

cpu usage http://192.168.8.106:9090/graph?g0.expr=sum%20by%20(mode%2Cinstance)%20(rate(node_cpu_seconds_total[1m]))%20&g0.tab=0&g0.stacked=0&g0.show_exemplars=0&g0.range_input=2h

portainer: https://192.168.8.106:9443
