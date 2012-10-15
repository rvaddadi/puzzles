class NotFoundException extends Exception {

    private static final long serialVersionUID = 6729390415796943874L;
}

public class BinarySearch {

    public static int search(int[] a, int search) throws NotFoundException {

        return search(a, search, 0, a.length);
    }

    private static int search(int[] a, int search, int i0, int i1)
            throws NotFoundException {

        int a0;
        int middle;
        int aMiddle;

        if (i0 > i1) {
            throw new NotFoundException();
        }

        if (i0 == i1) {
            if (a[i0] == search) {
                return i0;
            }
            else {
                throw new NotFoundException();
            }
        }

        a0 = a[i0];

        if (a0 == search) {
            return i0;
        }

        middle = (i0 + i1) / 2;
        aMiddle = a[middle];

        if (aMiddle == search) {
            return middle;
        }

        if (a0 < aMiddle) {
            if (search < aMiddle) {
                return search(a, search, i0 + 1, middle - 1);
            }
            else {
                return search(a, search, middle + 1, i1 - 1);
            }
        }

        if (search > aMiddle && search < a0) {
            return search(a, search, middle + 1, i1 - 1);
        }
        else {
            return search(a, search, i0 + 1, middle - 1);
        }
    }

    public static void main(String[] args) throws NotFoundException {

        search(new int[] { 15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14 }, 5);
    }
}
