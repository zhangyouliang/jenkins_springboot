package com.whatdy.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author youliangzhang
 * @date 2018/4/30  下午2:55
 **/
@RestController
public class HomeController {
    @GetMapping("/")
    public String index()
    {
        return "hello world";
    }
}
