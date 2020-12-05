cd /opt/frp
cat <<-EOF > /opt/frp/frps.ini
  [common]
  bind_port = $PORT
EOF

echo "Running FRP Server :D"
echo "Binding on the port $PORT"
/opt/frp/frps -c /opt/frp/frps.ini
