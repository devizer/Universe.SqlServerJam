using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Universe.SqlServerJam
{
    public class SqlServerJamConfiguration
    {
        static DbProviderFactory _SqlProviderFactory = SqlClientFactory.Instance;

        public static DbProviderFactory SqlProviderFactory
        {
            get => _SqlProviderFactory;
            set
            {
                if (value == null) throw new ArgumentNullException(nameof(value));
                _SqlProviderFactory = value;
            }
        }

        static SqlServerJamConfiguration()
        {
        }
    }
}
