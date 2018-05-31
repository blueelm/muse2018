using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace DataProtect
{
    public class DataProtector
    {
        private X509Certificate2 _x509;
        public DataProtector(X509Certificate2 cert)
        {
            _x509 = cert;
        }

        /// <summary>
        /// Encrypts a string value using random Key and IV value
        /// </summary>
        /// <param name="clearText"></param>
        /// <returns>Encrypted value with Key/IV prefix</returns>
        /// 1. Generate random Key and Initial Vector value
        /// 2. Encrypt Key and IV values (RSA)
        /// 3. Encrypt supplied clearText value (Rijndael)
        /// 4. Prefix encrypted Key + IV to encrypted clearText
        public byte[] ProtectBuffer(string clearText)
        {
            if (clearText == null)
                return null;

            byte[] pwProtected;
            using (Rijndael rj = Rijndael.Create())
            {
                // create an initial random password to encrypt our data
                var pw = new byte[rj.Key.Length + rj.IV.Length];
                rj.Key.CopyTo(pw, 0);
                rj.IV.CopyTo(pw, rj.Key.Length);

                // use slow (but strong) assymetrical encryption on our password
                pwProtected = EncryptAsymmetrical(pw);

                using (MemoryStream ms = new MemoryStream())
                using (CryptoStream cs = new CryptoStream(ms, rj.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    // use fast symmetrical encryption on the passed in value
                    var encode = Encoding.UTF8.GetBytes(clearText);
                    cs.Write(encode, 0, encode.Length);
                    cs.FlushFinalBlock();

                    // prefix the password + initial vector to the encrypted value
                    encode = new byte[ms.Length + 256];
                    pwProtected.CopyTo(encode, 0);
                    ms.ToArray().CopyTo(encode, 256);

                    return encode;
                }
            }
            
        }

        /// <summary>
        /// Decrypts a byte array that has been encrypted by ProtectBuffer
        /// </summary>
        /// <param name="encrpyted">Value that has been encrypted with ProtectBuffer</param>
        /// <returns>A decrypted string value</returns>
        /// 1. Decrypt the 256 byte prefix to get Key and IV 
        /// 2. Decrypt remainder using Key and IV 
        public string UnprotectBuffer(byte[] encrpyted)
        {
            if (encrpyted == null)
                return null;
            else if (encrpyted.Length < 256)
                throw new ArgumentException("encrypted");

            // extract the first 256 bytes and decrypt
            var clearpw = DecryptAsymmetrical(encrpyted.Take(256).ToArray());
            var key = clearpw.Take(32); // Rijndael key is 32 bytes
            var iv = clearpw.Skip(32).Take(16); // Rijndael iv is 16 bytes

            // now extract the remainder 
            using (Rijndael rj = RijndaelManaged.Create())
            using (MemoryStream ms = new MemoryStream(encrpyted.Skip(256).ToArray()))
            // decrypt using symmeterical (key and initial vector from encrypted value)
            using (CryptoStream cs = new CryptoStream(ms, rj.CreateDecryptor(key.ToArray(), iv.ToArray()), CryptoStreamMode.Read))
            {
                byte[] decrypted = new byte[encrpyted.Length - 256];
                cs.Read(decrypted, 0, decrypted.Length);
                return Encoding.UTF8.GetString(decrypted).TrimEnd('\0');
            }
            
        }

        /// <summary>
        /// Returns 44 character length hash of provided string
        /// </summary>
        /// <param name="clearText">The string to hash</param>
        /// <returns>SHA256 hash of clearText value</returns>
        public string CreateHash(string clearText)
        {
            if (String.IsNullOrEmpty(clearText))
                return clearText;

            using (SHA256 sha = SHA256CryptoServiceProvider.Create())
            {
                var hashed = sha.ComputeHash(Encoding.UTF8.GetBytes(clearText));
                return Convert.ToBase64String(hashed);
            }
        }

        private byte[] EncryptAsymmetrical (byte[] clearBytes)
        {
            var rsa = (RSACryptoServiceProvider)_x509.PublicKey.Key;
            return rsa.Encrypt(clearBytes, false);
        }

        private byte[] DecryptAsymmetrical (byte[] protectBytes)
        {
            if (!_x509.HasPrivateKey)
                throw new Exception("This certificate does not have a private key!");

            var rsa = (RSACryptoServiceProvider)_x509.PrivateKey;
            return rsa.Decrypt(protectBytes, false);
        }
            

    }

    
}
