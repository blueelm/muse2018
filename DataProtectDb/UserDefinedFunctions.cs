using System;
using System.Data.SqlTypes;
using DataProtect;
using System.Security.Cryptography.X509Certificates;

public partial class UserDefinedFunctions
{
    // Self-Signed Certificate => We are the issuer! 
    private static X509Certificate2 x509 => GetCertificateByIssuerName(Environment.MachineName, requireValid: false);

    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlBinary Protect(string clearText)
    {
        var dp = new DataProtector(x509);
        var encrypt = dp.ProtectBuffer(clearText);
        return new SqlBinary(encrypt);
    }

    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlString Unprotect(byte[] protectedBlob)
    {
        var dp = new DataProtector(x509);
        var decrypt = dp.UnprotectBuffer(protectedBlob);
        return new SqlString(decrypt);
    }

    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlString ComputeHash(string clearText)
    {
        var dp = new DataProtector(x509);
        var hash = dp.CreateHash(clearText);
        return new SqlString(hash);
    }

    private static X509Certificate2 GetCertificateByThumbprint(string thumbprint, bool requireValid) => GetCertificate(X509FindType.FindByThumbprint, thumbprint, requireValid);
    private static X509Certificate2 GetCertificateByIssuerName(string issuerName, bool requireValid) => GetCertificate(X509FindType.FindByIssuerName, issuerName, requireValid);
    private static X509Certificate2 GetCertificate(X509FindType findtype, object searchValue, bool requireValid)
    {
        using (X509Store store = new X509Store(StoreLocation.LocalMachine))
        {
            store.Open(OpenFlags.ReadOnly);
            X509Certificate2Collection certs = store.Certificates.Find(findtype, searchValue, requireValid);

            if (certs.Count < 1)
            {
                throw new SystemException($"Certificate not found. FindType: {findtype} Thumbprint: {searchValue}");
            }
            store.Close();
            return certs[0];
        }

    }
}
