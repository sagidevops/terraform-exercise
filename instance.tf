resource "aws_instance" "ec2_linux" {
    ami = var.ami_linux
    instance_type = var.instance_type
    subnet_id = aws_subnet.main-private-1.id
    vpc_security_group_ids = [aws_security_group.canada_ec2_linux.id]
    key_name = aws_key_pair.mykeypair.key_name
    tags = {
      Name = "sagie-terraform-exercise-linux"
    }
}

resource "aws_instance" "ec2_windows" {
    ami = data.aws_ami.windows-ami.image_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.main-public-1.id
    vpc_security_group_ids = [aws_security_group.canada_ec2_win.id]
    key_name = aws_key_pair.mykeypair.key_name
      tags = {
      Name = "sagie-terraform-exercise-windows"
    }
    user_data     = <<EOF
<powershell>
net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add
winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF
}
