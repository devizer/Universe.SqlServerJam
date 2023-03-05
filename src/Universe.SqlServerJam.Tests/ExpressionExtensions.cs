using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;

namespace Universe.SqlServerJam.Tests
{
    public static class ExpressionExtensions
    {
        public static string GetTitle1<TSource, TProperty>(
            Expression<Func<TSource, TProperty>> propertyLambda)
        {
            var body = propertyLambda.Body;
            var operand = GetProperty(body, "Operand");
            var member = GetProperty(operand, "Member");
            // return member.ToString();
            PropertyInfo property = (PropertyInfo)member;
            return $"[{property.PropertyType.Name}] {property.Name}";
        }

        static object GetProperty(object arg, string name)
        {
            var property = arg.GetType().GetProperty(name);
            return property.GetValue(arg, new object[0]);
        }

        public static PropertyInfo GetPropertyInfo<TSource, TProperty>(
            Expression<Func<TSource, TProperty>> propertyLambda)
        {
            Type type = typeof(TSource);

            MemberExpression member = propertyLambda.Body as MemberExpression;
            if (member == null)
                throw new ArgumentException(string.Format(
                    "Expression '{0}' refers to a method, not a property.",
                    propertyLambda.ToString()));

            PropertyInfo propInfo = member.Member as PropertyInfo;
            if (propInfo == null)
                throw new ArgumentException(string.Format(
                    "Expression '{0}' refers to a field, not a property.",
                    propertyLambda.ToString()));

            if (type != propInfo.ReflectedType &&
                !type.IsSubclassOf(propInfo.ReflectedType))
                throw new ArgumentException(string.Format(
                    "Expression '{0}' refers to a property that is not from type {1}.",
                    propertyLambda.ToString(),
                    type));

            return propInfo;
        }

    }
}
