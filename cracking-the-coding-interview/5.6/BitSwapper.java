public class BitSwapper {

    public static void main(String[] args) {

        int num = 216; // 11011000
        int answer = 228; // 11100100

        int mask = 0x55555555; // 0101010...

        int temp;

        temp = num & mask;
        mask = ~mask;
        num &= mask;
        num >>= 1;
        temp <<= 1;
        num |= temp;

        System.out.println(num);
        System.out.println(answer);
    }
}
