# Enable PowerShell Remoting
Enable-PSRemoting -Force -SkipNetworkProfileCheck

# Generate a self-signed certificate for the VM (using the computer name as the DNS name)
$cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My
$thumbprint = $cert.Thumbprint

# Create a new HTTPS listener on port 5986
$listenerConfig = "@{Hostname=`"$env:COMPUTERNAME`"; CertificateThumbprint=`"$thumbprint`"; Port=`"5986`"}"
winrm create winrm/config/Listener?Address=*+Transport=HTTPS $listenerConfig

# Configure WinRM service settings:
# - Only allow encrypted connections
# - Enable Basic and CredSSP authentication
winrm set winrm/config/service '@{AllowUnencrypted="false"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{CredSSP="true"}'

# Open the Windows Firewall for inbound TCP traffic on port 5986
New-NetFirewallRule -Name "WINRM-HTTPS-In-TCP" `
    -DisplayName "Windows Remote Management (HTTPS-In)" `
    -Direction Inbound -Protocol TCP -LocalPort 5986 `
    -Action Allow -Enabled True

# Set TrustedHosts to allow connections from any host (adjust for production)
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value "*" -Force

Write-Host "WinRM has been configured successfully on port 5986!"
Write-Host "Certificate Thumbprint: $thumbprint"

