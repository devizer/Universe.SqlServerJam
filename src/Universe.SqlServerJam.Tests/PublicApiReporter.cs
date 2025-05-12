using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Collections.Generic;

namespace AssemblyPublicApiReporter
{
    public class PublicApiReporter
    {
        public static string GenerateReport(Type[] exportedTypes)
        {
            var sb = new StringBuilder();

            foreach (var type in exportedTypes)
            {
                sb.AppendLine($"Type: {FormatTypeName(type)}");
                sb.AppendLine(new string('-', 80));

                // Constructors
                foreach (var ctor in type.GetConstructors(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static))
                {
                    sb.AppendLine($"  Constructor: {FormatMethodSignature(ctor)}");
                }

                // Methods
                foreach (var method in type.GetMethods(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly)
                                           .Where(m => !m.IsSpecialName))
                {
                    sb.AppendLine($"  Method: {FormatMethodSignature(method)}");
                }

                // Properties
                /*
                foreach (var prop in type.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly))
                {
                    sb.AppendLine($"  Property: {FormatTypeName(prop.PropertyType)} {prop.Name}");
                }
                */

                // Properties with readonly/writeonly detection
                foreach (var prop in type.GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly))
                {
                    sb.AppendLine($"  Property: {FormatProperty(prop)}");
                }

                // Fields
                foreach (var field in type.GetFields(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly))
                {
                    sb.AppendLine($"  Field: {FormatTypeName(field.FieldType)} {field.Name}");
                }

                // Events
                foreach (var evt in type.GetEvents(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly))
                {
                    sb.AppendLine($"  Event: {FormatTypeName(evt.EventHandlerType)} {evt.Name}");
                }

                sb.AppendLine();
            }

            return sb.ToString();

        }
        public static string GenerateReport(Assembly assembly)
        {
            if (assembly == null)
                throw new ArgumentNullException(nameof(assembly));

            var exportedTypes = assembly.GetExportedTypes().OrderBy(t => t.FullName);
            return GenerateReport(exportedTypes.ToArray());
        }

        private static string FormatMethodSignature(MethodBase method)
        {
            var parameters = method.GetParameters();
            var parameterList = string.Join(", ", parameters.Select(p => $"{FormatTypeName(p.ParameterType)} {p.Name}").ToArray());
            var methodName = method.IsConstructor ? method.DeclaringType?.Name : method.Name;

            // Handle generic method parameters
            if (method.IsGenericMethod)
            {
                var genericArgs = method.GetGenericArguments();
                methodName += $"<{string.Join(", ", genericArgs.Select(FormatTypeName).ToArray())}>";
            }

            if (method is MethodInfo mi)
            {
                return $"{FormatTypeName(mi.ReturnType)} {methodName}({parameterList})";
            }

            return $"void {methodName}({parameterList})";
        }

        private static string FormatTypeName(Type type)
        {
            if (type == null)
                return "void";

            if (type.IsGenericParameter)
                return type.Name;

            if (type.IsArray)
                return $"{FormatTypeName(type.GetElementType())}[]";

            var nameBuilder = new StringBuilder();

            // Handle Nested Types with Generic Arguments
            if (type.IsNested)
            {
                nameBuilder.Append(FormatTypeName(type.DeclaringType));
                nameBuilder.Append(".");
            }

            // Handle Generic Types
            if (type.IsGenericType)
            {
                string typeName = type.Name;
                int backtickIndex = typeName.IndexOf('`');
                if (backtickIndex > 0)
                    typeName = typeName.Substring(0, backtickIndex);

                nameBuilder.Append(typeName);
                nameBuilder.Append("<");

                var genericArguments = type.GetGenericArguments();

                // If this is a nested type, generic arguments are shared with declaring type
                // So we only want to print the ones declared for THIS type
                var declaringType = type.DeclaringType;
                int declaringGenericCount = declaringType?.GetGenericArguments().Length ?? 0;
                var ownGenericArgs = genericArguments.Skip(declaringGenericCount);

                nameBuilder.Append(string.Join(", ", ownGenericArgs.Select(FormatTypeName).ToArray()));
                nameBuilder.Append(">");
            }
            else
            {
                nameBuilder.Append(type.Name);
            }

            return nameBuilder.ToString();
        }

        private static string FormatProperty(PropertyInfo prop)
        {
            string typeName = FormatTypeName(prop.PropertyType);

            bool hasGetter = prop.GetGetMethod() != null;
            bool hasSetter = prop.GetSetMethod() != null;

            string accessors = hasGetter && hasSetter ? "" : hasGetter ? " readonly" : " writeonly";

            return $"{typeName} {prop.Name}{accessors}";
        }
    }
}
