package com.landray.kmss.geesun.base.util.test;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.landray.kmss.geesun.base.util.rowmapper.RowMapper;

public class PersonRowMapper implements RowMapper<Person>{
	
private static PersonRowMapper INSTANCE;
	
	private PersonRowMapper() {
		
	}
	
	public static PersonRowMapper getInstance() {
		if (INSTANCE == null) {
			synchronized(PersonRowMapper.class) {
				if (INSTANCE == null) {
					INSTANCE = new PersonRowMapper();
				}
			}
		}
		return INSTANCE;
	}

	@Override
	public Person mapRow(ResultSet rs, int rowNum) throws SQLException {
		Person person = new Person();
		person.setId(rs.getInt("fd_id"));
		person.setName(rs.getString("fd_name"));
		return person;
	}

}
