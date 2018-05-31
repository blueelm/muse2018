param (
    $inputPassword = $( Read-Host -AsSecureString 'Create Certificate Password' )
)
$fqdn = [System.Net.Dns]::GetHostByName(($env:computerName)) | FL HostName | Out-String | % { "{0}" -f $_.Split(':')[1].Trim() }
ConvertFrom-SecureString $inputPassword | out-file .\certpass.pwd
$certPassword = Get-Content .\certpass.pwd | ConvertTo-SecureString
$cert = New-SelfSignedCertificate -Provider "Microsoft Strong Cryptographic Provider" -KeyLength 2048 -KeySpec KeyExchange -KeyExportPolicy Exportable -KeyUsage DigitalSignature,DataEncipherment -HashAlgorithm SHA512 -DnsName $fqdn -Type CodeSigningCert -KeyAlgorithm RSA -CertStoreLocation 'Cert:\LocalMachine\My'
Export-PfxCertificate -Cert "cert:\LocalMachine\My\$($cert.Thumbprint)" -FilePath "muse2018.pfx" -Password $certPassword
Export-Certificate -Cert "cert:\LocalMachine\My\$($cert.Thumbprint)" -FilePath "muse2018.cer"