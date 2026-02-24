package com.cx.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cx.web.entity.User;
import com.cx.web.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User login(String memId, String memPw) {
        User user = userRepository.findByMemId(memId);
        if (user != null && user.getMemPw().equals(memPw)) {
            return user;
        }
        return null;
    }
}
