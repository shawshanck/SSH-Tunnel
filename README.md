# SSH-Tunnel
With this script you can create a SSH Tunnel between 2 servers. Everything is automatic on this script.


<h2>Installation:</h2>

Just copy and paste the commands below and press enter!

- First, install curl:

- ![#f03c15] Ubuntu:

apt install curl
```

Cent OS:
```
sudo dnf install curl
```

Then use the command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/install.sh --ipv4)
```
<hr>

To add new tunnel for the same destination IP address, use command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/add.sh --ipv4)
```

To add new tunnel for a new destination IP address, use command below:

```
bash <(curl -Ls https://raw.githubusercontent.com/shawshanck/SSH-Tunnel/main/addnew.sh --ipv4)
```
<hr>
