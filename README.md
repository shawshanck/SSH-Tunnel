<h1 align="center">"SSH Tunnel"</h1>

<p align="center">
<img src="https://cdn-thumbs.imagevenue.com/c0/c2/e6/ME16R3YN_b.png" width="100">
<br>
</p>

<p align="center">With this script you can create a SSH Tunnel between 2 or more servers. Everything is automatic on this script.</p>

<hr>

<h2>Installation:</h2>

Just copy and paste the commands below and press enter!

- First, install curl:

Ubuntu:
```
apt install curl
```

Cent OS:
```
sudo dnf install curl
```

- Then use the command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/install.sh --ipv4)
```
<hr>

- To add new tunnel for the same destination IP address, use command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/add.sh --ipv4)
```

- To add new tunnel for a new destination IP address, use command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/addnew.sh --ipv4)
```
<hr>

<h3>Notes:</h3>

This script saves a tunnel.sh file and a cronjob which runs automatically after machine reboot. So there is no need to configure the tunnels every time.

To edit configured tunnels refer to tunnel.sh file and edit it with desired editor. For example:

```
nano /usr/local/bin/tunnel.sh
```
