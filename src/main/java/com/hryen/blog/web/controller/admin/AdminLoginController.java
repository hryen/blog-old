package com.hryen.blog.web.controller.admin;

import com.hryen.blog.model.Result;
import com.hryen.blog.model.User;
import com.hryen.blog.service.UserService;
import com.hryen.blog.service.CommonService;
import eu.bitwalker.useragentutils.UserAgent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private UserService userService;

    @Autowired
    private CommonService commonService;

    // admin登录页面
    @GetMapping("/login")
    public String getAdminLogin(@CookieValue(value = "UID", required = false) String UID,
                                HttpServletRequest request, Model model) {

        // 获取userAgent
        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));

        // 从redis获取与当前请求一致的agent.id的value
        String redisUserId = stringRedisTemplate.boundValueOps("blog_user_agent_id_" + userAgent.getId()).get();

        // 如果redis中存在 并且value和UID的值一样 执行登录操作
        if(null != redisUserId && redisUserId.equals(UID)) {
            // 调用service登录的方法
            User user = userService.getUserById(UID);
            // 将该用户放入session
            request.getSession().setAttribute("user", user);
            //跳转到admin首页
            return "redirect:/admin";
        }

        // 尝试从session中获取user
        Object user = request.getSession().getAttribute("user");

        // 如果已登录 跳转到admin首页
        if (null != user) {
            return "redirect:/admin";
        }

        String blogTitle = commonService.getBlogTitle();
        model.addAttribute("blogTitle", blogTitle);
        // 返回登录页面
        return "admin/login";
    }

    // 接收前台的登录表单 进行登录操作
    @PostMapping("/login")
    @ResponseBody
    public Result login(@RequestBody Map data, HttpServletRequest request,
                        HttpServletResponse response, Model model) {

        String username = (String) data.get("username");
        String password = (String) data.get("password");
        boolean remember = (boolean) data.get("remember");

        // 调用service登录的方法
        User user = userService.login(username, password);

        // 如果登录成功
        if (null != user) {
            // 1.将user加入session
            request.getSession().setAttribute("user", user);

            // 如果使用了remember me功能 向客户端发放cookie
            if (remember) {
                // 获取UserAgent 里面包含id 系统信息 浏览器信息等
                UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));

                /**
                 * 用户在redis中存在方式
                 *
                 * 1.登录成功 发放一个cookie 并将该useragent的id放入redis 并设置过期时间和cookie一样
                 *
                 * 例如 cookie是 UID:3   |   redis是 blog_user_agent_id_35131137:3
                 *
                 * cookie U代表是user id   |   redis的key是blog_user_agent_id_ + useragent.id value是user.id
                 *
                 * 2.验证cookie的步骤
                 *     1.获取请求的cookie的uid和userAgent.id
                 *     2.根据该agent.id去redis里查找 如果没找到 代表cookie被复制 因为redis里的过期时间和cookie里一样
                 *       如果cookie存在 redis里不存在 那一定是有问题的
                 *     3.验证cookie的uid和redis的agent.id的value是否一样 一样则直接将该用户放入session
                 */

                // 2.将userAgent.id放入redis
                stringRedisTemplate.boundValueOps("blog_user_agent_id_" + userAgent.getId())
                        .set(String.valueOf(user.getId()), 7L, TimeUnit.DAYS);

                // 设置uid cookie
                Cookie cookie = new Cookie("UID", user.getId());
                // 7天
                cookie.setMaxAge(60*60*24*7);
                // cookie只能使用https协议发送给服务器
                /// cookie.setSecure(true);
                // HttpOnly可以防止js脚本读取cookie信息 防止XSS攻击
                cookie.setHttpOnly(true);

                // 3.发放cookie
                response.addCookie(cookie);
            }

            // 返回登录成功
            return new Result(true, "Successful");
        } else {
            // 返回登录失败
            return new Result(false, "Username or password is incorrect");
        }
    }

}
