package com.cx.web.repository;


import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cx.web.entity.Member;

public interface MemberRepository extends JpaRepository<Member, String>{

	Optional<Member> findByMemIDAndMemPW(String memID, String memPW);
	boolean existsByMemID(String memID);
	
	@Query("SELECT COUNT(m) FROM Member m WHERE FUNCTION('MONTH',m.joinedAt) = FUNCTION('MONTH',CURRENT_DATE) AND FUNCTION('YEAR', m.joinedAt) = FUNCTION('YEAR', CURRENT_DATE)")
	Long countThisMonth();
	
	
	List<Member> findByMemTypeOrderByJoinedAtDesc(String memType);
	long countByMemType(String memType);
	
	@Query("""
			SELECT COUNT(m)
			FROM Member m
			WHERE m.memType = :memType
				AND FUNCTION('MONTH', m.joinedAt) = FUNCTION('MONTH', CURRENT_DATE)
				AND FUNCTION('YEAR', m.joinedAt) = FUNCTION('YEAR', CURRENT_DATE)
			""")
	long countThisMonthByType(@Param("memType") String memType);
	
	@Query("""
			
			SELECT COUNT(m)
			FROM Member m
			WHERE m.memType = 'USER'
				AND m.lastLoginAt IS NOT NULL
				AND FUNCTION('DATE', m.lastLoginAt) = CURRENT_DATE
			""")
	long countTodayLoginUsers();
	
	@Query("SELECT COUNT(m) FROM Member m WHERE m.memType = :memType AND m.warnCnt > 0")
	long countWarnUsers(@Param("memType") String memType);
	
	@Query("""
			SELECT COUNT(m)
			FROM Member m
			WHERE m.memType = :memType
				AND m.joinedAt >= :start
				AND m.joinedAt < :end
			""")
	long countByTypeBetween(
			@Param("memType") String memType,
			@Param("start") java.time.LocalDateTime start,
			@Param("end") java.time.LocalDateTime end			
			);
	
	@Query("""
			SELECT COUNT(m)
			FROM Member m
			WHERE m.memType = :memType
			  AND m.lastLoginAt >= :start
			  AND m.lastLoginAt < :end
			""")
			long countLoginByTypeBetween(
			    @Param("memType") String memType,
			    @Param("start") java.time.LocalDateTime start,
			    @Param("end") java.time.LocalDateTime end
			);
	
	Page<Member> findByMemTypeOrderByJoinedAtDesc(String memType, Pageable pageable);
	
	Page<Member> findByMemTypeAndMemIDContainingIgnoreCaseOrMemTypeAndMemNameContainingIgnoreCaseOrderByJoinedAtDesc(
			String memType1, String memID,
			String memType2, String memName,
			Pageable pageable );
	
	@Query("""
		    SELECT m
		    FROM Member m
		    WHERE m.memType = 'USER'
		      AND (:district = '' OR m.memAddr = :district)
		      AND (:kw = '' OR LOWER(m.memID) LIKE LOWER(CONCAT('%', :kw, '%'))
		                OR LOWER(m.memName) LIKE LOWER(CONCAT('%', :kw, '%')))
		      AND (:startBirth IS NULL OR m.memBirthdate >= :startBirth)
		      AND (:endBirth   IS NULL OR m.memBirthdate <= :endBirth)
		    ORDER BY m.joinedAt DESC
		""")
		Page<Member> searchUsers(
		    @Param("district") String district,
		    @Param("startBirth") LocalDate startBirth,
		    @Param("endBirth") LocalDate endBirth,
		    @Param("kw") String kw,
		    Pageable pageable
		);
	
	List<Member> findByMemTypeAndMemAddr(String memType, String memAddr);
}

