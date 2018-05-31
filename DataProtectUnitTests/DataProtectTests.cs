using System;
using Xunit;
using DataProtect;
using System.Security.Cryptography.X509Certificates;
using System.Runtime.InteropServices;

namespace DataProtect.UnitTests
{
    
    public class DataProtectTests : IDisposable
    {
        private X509Certificate2 _cert;

        public DataProtectTests()
        {
            Assert.True(TestHelper.IsUserAnAdmin(), "Must run tests with VS running as an admin");
            _cert =  TestHelper.CreateSelfSignedCertificate("DATA PROTECT UNIT TESTS", new TimeSpan(0, 5, 0));
        }

        [Theory]
        [InlineData("short string")]
        [InlineData("longgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg string")]
        public void TestProtectUnProtect(string clearText)
        {
            
            var dt = new DataProtector(_cert);
            var bytes = dt.ProtectBuffer(clearText);
            var unencrypted = dt.UnprotectBuffer(bytes);
            Assert.Equal(clearText, unencrypted);
        }

        [Fact]
        public void TestProtectNullString()
        {
            var dt = new DataProtector(_cert);
            var bytes = dt.ProtectBuffer(null);
            var unencrypted = dt.UnprotectBuffer(bytes);
            Assert.Null(unencrypted);
        }

        [Fact]
        public void TestProtectEmptyString()
        {
            var dt = new DataProtector(_cert);
            var bytes = dt.ProtectBuffer(String.Empty);
            var unencrypted = dt.UnprotectBuffer(bytes);
            Assert.Equal(String.Empty, unencrypted);
        }

        // hashing the same value x2 should yield the same result
        [Theory]
        [InlineData("some string")]
        public void TestHash(string hashable)
        {
            var dt = new DataProtector(_cert);
            Assert.Equal(dt.CreateHash(hashable), dt.CreateHash(hashable));

        }

        [Fact]
        public void TestHash_Null()
        {
            var dt = new DataProtector(_cert);
            Assert.Null(dt.CreateHash(null));
        }

        [Fact]
        public void TestHash_EmptyString()
        {
            var dt = new DataProtector(_cert);
            Assert.Equal(String.Empty, dt.CreateHash(String.Empty));
        }

        public void Dispose()
        {
            TestHelper.RemoveCertificate(_cert);
        }
    }
}
