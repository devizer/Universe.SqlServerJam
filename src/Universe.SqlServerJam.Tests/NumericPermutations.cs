using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;

namespace Universe.SqlServerJam.Tests
{
    // Narayana Pandita’s algorithm that returns indexes only
    public static class SimplePermutations
    {
        // wrapper
        public static IEnumerable<IEnumerable<T>> GetAll<T>(this IEnumerable<T> elements) => GetAll(elements, false);
        public static IEnumerable<IEnumerable<T>> GetAllIsolated<T>(this IEnumerable<T> elements) => GetAll(elements, true);
        public static IEnumerable<IEnumerable<T>> GetAll<T>(this IEnumerable<T> elements, bool needNewCopy)
        {
            var arr = elements.ToArray();
            var elementsCount = arr.Length;
            var ret = new T[elementsCount];
            foreach (var next in GetAll(elementsCount, false))
            {
                for(int i=0; i<ret.Length; i++) ret[i] = arr[next[i]];
                if (needNewCopy)
                {
                    T[] copy = new T[ret.Length];
                    for (int i = 0; i <= ret.Length; i++) copy[i] = ret[i];
                    yield return copy;
                }
                else yield return ret;
            }
        }

        
        // core
        public static IEnumerable<int[]> GetAll(int elementsCount) => GetAll(elementsCount, false);
        public static IEnumerable<int[]> GetAllIsolated(int elementsCount) => GetAll(elementsCount, true);

        // Zero based
        public static IEnumerable<int[]> GetAll(int elementsCount, bool needNewCopy)
        {
            if (elementsCount == 0) yield break;
            if (elementsCount == 1)
            {
                yield return new int[1] { 0 };
                yield break;
            }

            int[] array = new int[elementsCount];
            for(int i = 0; i < elementsCount; i++) array[i] = i;
            // first is 0, 1, 2, ... elementsCount
            if (needNewCopy)
            {
                int[] copy = new int[elementsCount];
                for (int i = 0; i < elementsCount; i++) copy[i] = array[i];
                yield return copy;
            }
            else
            {
                yield return array;
            }

            // next in a loop
            while (NextPermutation(array))
            {
                if (needNewCopy)
                {
                    int[] copy = new int[elementsCount];
                    for (int i = 0; i < elementsCount; i++) copy[i] = array[i];
                    yield return copy;
                }
                else
                {
                    yield return array;
                }
            }
        }

#if NET46_OR_GREATER || NETCOREAPP3_1_OR_GREATER
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
#endif
        static bool NextPermutation(int[] array)
        {
            int n = array.Length;

            int i = n - 2;
            while (i >= 0 && array[i] >= array[i + 1]) i--;
            if (i < 0) return false;

            int j = n - 1;
            while (array[j] <= array[i]) j--;

            // Swap(array, i, j);
            Swap(ref array[i], ref array[j]);
            Reverse(ref array, i + 1, n - 1);

            return true;
        }

#if NET46_OR_GREATER || NETCOREAPP3_1_OR_GREATER
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
#endif
        static void Swap(ref int i, ref int j)
        {
            int temp = i;
            i = j; 
            j = temp;
        }

#if NET46_OR_GREATER || NETCOREAPP3_1_OR_GREATER
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
#endif
        static void Reverse(ref int[] array, int start, int end)
        {
            while (start < end)
            {
                // Swap(array, start, end);
                Swap(ref array[start], ref array[end]);
                start++;
                end--;
            }
        }
    }

}
