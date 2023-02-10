package kwaktaemoon.flower.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor 
public class UserDto {
	private String userId;
	private String userPw;
}
