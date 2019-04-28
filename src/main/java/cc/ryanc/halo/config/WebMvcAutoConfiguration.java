package cc.ryanc.halo.config;

import cc.ryanc.halo.filter.CorsFilter;
import cc.ryanc.halo.web.interceptor.ApiInterceptor;
import cc.ryanc.halo.web.interceptor.InstallInterceptor;
import cc.ryanc.halo.web.interceptor.LocaleInterceptor;
import cc.ryanc.halo.web.interceptor.LoginInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import java.util.Locale;

/**
 * <pre>
 *     拦截器，资源路径配置
 * </pre>
 *
 * @author : RYAN0UP
 * @date : 2018/1/2
 */
@Slf4j
@Configuration
/*
@EnableWebMvc 作用：
使用java 配置 mvc ，代替之前的springmvc 配置文件
 */
@EnableWebMvc
@ComponentScan(basePackages = "cc.ryanc.halo.web.controller")
@PropertySource(value = "classpath:application.yaml", ignoreResourceNotFound = true, encoding = "UTF-8")
public class WebMvcAutoConfiguration implements WebMvcConfigurer {

    @Autowired
    private LoginInterceptor loginInterceptor;

    @Autowired
    private InstallInterceptor installInterceptor;

    @Autowired
    private ApiInterceptor apiInterceptor;

    @Autowired
    private LocaleInterceptor localeInterceptor;

    /**
     * 注册拦截器
     *
     * @param registry registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/admin.*")
                .addPathPatterns("/admin/**")
                .addPathPatterns("/backup/**")
                .excludePathPatterns("/admin/login")
                .excludePathPatterns("/admin/getLogin")
                .excludePathPatterns("/static/**");
        /*
         除了 安装 路径外，
         访问其他路径都要验证是否安装，如果没有安装，则跳转到安装页面。
         */
        registry.addInterceptor(installInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/install")
                .excludePathPatterns("/install/do")
                .excludePathPatterns("/static/**");
        registry.addInterceptor(apiInterceptor)
                .addPathPatterns("/api/**");
        registry.addInterceptor(localeInterceptor)
                .addPathPatterns("/admin.*")
                .addPathPatterns("/admin/**")
                .addPathPatterns("/install");
        registry.addInterceptor(localeChangeInterceptor())
                .addPathPatterns("/install");
    }

    /**
     * 配置静态资源路径
     *
     * @param registry registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/templates/themes/");
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///" + System.getProperties().getProperty("user.home") + "/halo/upload/");
        registry.addResourceHandler("/favicon.ico")
                .addResourceLocations("classpath:/static/halo-backend/images/favicon.ico");
        registry.addResourceHandler("/backup/**")
                .addResourceLocations("file:///" + System.getProperties().getProperty("user.home") + "/halo/backup/");
    }

//    /**
//     * 跨域
//     *
//     * @param registry registry
//     */
//    @Override
//    public void addCorsMappings(CorsRegistry registry) {
//        registry.addMapping("/api/**")
//                .allowedHeaders("*")
//                .allowedOrigins("*")
//                .allowedMethods("GET", "POST")
//                .exposedHeaders("access-control-allow-headers",
//                        "access-control-allow-methods",
//                        "access-control-allow-origin",
//                        "access-control-max-age",
//                        "X-Frame-Options",
//                        "token")
//                .allowCredentials(false).maxAge(3600);
//    }

    /**
     * Creates a CorsFilter.
     *
     * @return Cors filter registration bean
     */
    @Bean
    FilterRegistrationBean<CorsFilter> corsFilter() {
        FilterRegistrationBean<CorsFilter> corsFilter = new FilterRegistrationBean<>();

        corsFilter.setOrder(Ordered.HIGHEST_PRECEDENCE);
        corsFilter.setFilter(new CorsFilter());
        corsFilter.addUrlPatterns("/api/*");

        return corsFilter;
    }

    /**
     * 国际化设置，生成 LocalResolver bean.
     *
     *  在视图解析时，需要 获得 ResourceBundleMessageSource,获得Message 时 需要获得 local ,这是需要local 解析器获得local .根据 local 获得相应的 message
     * @return LocaleResolver
     */
    @Bean
    public LocaleResolver localeResolver() {
        final SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(Locale.CHINA);
        return slr;
    }

    /**
     * 国际化参数拦截器
     * LocaleChangeInterceptor 拦截 参数lang 的值，将值放入 session 中。
     * @return LocaleChangeInterceptor
     */
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        final LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }
}
