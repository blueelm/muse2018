# 1046 - Identify, Anonymize, and Encrypt Your Data Repository PHI Data

*Have you considered all of the security implications when using Data Repository (DR) as a data source for your in-house applications? 
DR is a game changer when it comes to the availability and convenience of data access in the MEDITECH system. How do we protect data once
we’ve extracted it from the friendly confines of the DR? During this session we will identify the data that MEDITECH stores within its
own schema to denote items it considers to be Protected Health Information (PHI). We’ll discuss how to apply this metadata to the Data Repository
in order to identify columns that need to be protected. Finally, we will consider the various capabilities within SQL Server to encrypt data at rest 
and evaluate the strengths and drawbacks of each.*

This repository contains the slides, notes, and proof of concept project as presented during session 1046 at the Muse Inspire 2018 conference. The DataProtect project contains the code to create an 
assembly which can be used to encrypt and decrypt information using PKI. Please keep in mind that none of this software is designed or tested to be used in a production capacity so 
please proceed at your own risk! 

## Preparing the environment
Before the projects can compile / run it's necessary to either create or use a certificate file which will be used to encrypt and decrypt data
and also sign the assemblies used in the database project. You can create your own certificate using the included setup.bat 
file. Running this batch file will:

1. Prompt for a password and store it securely in a file (certpass.pwd)
2. Create a self signed certificate in the local machine store (Cert:\LocalMachine\My) 
3. Export a password protected .pfx file containing the certificate private key (muse2018.pfx)
4. Export the public key of the certificate (muse2018.cer)
 
## Publishing the database project
Please don't attempt to publish this database project to your MEDITECH DR databases! **You have been warned!**

1. Add some data to the post-deployment script (optional)
2. Create a publish profile for your database 
3. Build / Publish the project to build the database objects and load with data

#### Assembly Signing
The database project uses the DataProtect assembly, running it via the SQL Server CLR. The DataProtect assembly reads the certificate
public (and private) keys from the Windows Certificate Store. In order to enable this functionaly, the assembly must be blessed
with EXTERNAL_ACCESS permission when it's created via a CREATE ASSEMBLY statement. In order to make the installation as simple
as possible the build/publish steps use the self-signed certificate that was created in the setup.bat to also sign the project
assemblies. When the database is published, the public key of the certificate is registered with SQL Server, and a 
login is created to access and run the assembly. Since the certificate and the assembly use the same public/private key pair, SQL Server
permits the DataProtectDb assembly to read the Windows Certificate Store. 

#### Using the certificate private key
If you would like to decrypt data within SQL Server then it's necessary to grant the user running the SQL Server process
permission to the private key. This is accomplished by using the certificates (local machine) snap-in for the Microsoft
Management Console. 

1. Start -> Run -> mmc.exe
2. File -> Add / Remove Snap-ins
3. Locate Certificates from the 'Available snap-ins'. Add 
4. 'This snap-in will always manage certificates for': Computer Account
5. Next -> Finish -> Okay
6. Console Root -> Certificates -> Personal -> Certificates
7. Right-Click Certificate -> All Tasks -> Manage Private Keys
8. Add the appropriate user(s) / group(s)

### License
MIT License

Copyright (c) 2018 Blue Elm Company LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
