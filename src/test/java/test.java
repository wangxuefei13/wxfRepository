import com.crm.utils.DateTimeUtils;
import com.crm.utils.MD5UTils;

public class test {


    public static void main(String[] args) {
        //验证失效时间
        //失效时间
        String expireTime = "2018-08-10 10:10:10";
        //当前系统时间
        String currenTime = DateTimeUtils.getSysTime();
        int count = expireTime.compareTo(currenTime);
        System.out.println( );

        String str  = MD5UTils.getMD5("123");
        System.out.println(str);
    }
}
