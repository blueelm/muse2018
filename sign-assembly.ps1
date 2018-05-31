param ([string]$SolutionDir, [string]$TargetPath)
try
{
$certPath = Join-Path -Path $SolutionDir -ChildPath 'muse2018.pfx'
$pwdPath = Join-Path -Path $SolutionDir -ChildPath 'certpass.pwd'
$pwd = Get-Content $pwdPath | ConvertTo-SecureString
$Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath,$pwd)
Set-AuthenticodeSignature -FilePath $TargetPath -Certificate $Cert
}
catch 
{
	#So that VS knows we failed :(
	exit -1
}