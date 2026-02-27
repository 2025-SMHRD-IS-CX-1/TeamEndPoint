package com.cx.web;

import java.sql.Connection;

import javax.sql.DataSource;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DbTestController {

	private final DataSource dataSource;
	
	public DbTestController(DataSource dataSource) {
        this.dataSource = dataSource;
        }
	
	@GetMapping("/dbtest")
	public String dbtest() throws Exception{
		 try (Connection conn = dataSource.getConnection()) {
	            return "DB OK ✅ : " + conn.getMetaData().getURL();
	   }
	}
}
