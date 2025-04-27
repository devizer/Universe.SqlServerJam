using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

namespace Universe.SqlServerJam.Tests
{
    // Narayana Pandita’s algorithm that returns indexes only
    public static class SimplePermutations
    {
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

            Swap(array, i, j);
            Reverse(array, i + 1, n - 1);

            return true;
        }

#if NET46_OR_GREATER || NETCOREAPP3_1_OR_GREATER
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
#endif
        static void Swap(int[] array, int i, int j)
        {
            int temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }

#if NET46_OR_GREATER || NETCOREAPP3_1_OR_GREATER
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
#endif
        static void Reverse(int[] array, int start, int end)
        {
            while (start < end)
            {
                Swap(array, start, end);
                start++;
                end--;
            }
        }
    }

}
