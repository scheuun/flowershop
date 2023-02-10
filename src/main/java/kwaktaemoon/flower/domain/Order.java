package kwaktaemoon.flower.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Order {
	private int orderNum;
	private int amount;
	private String recName;
	private String recContactNum;
	private String recPostCode;
	private String recAddr;
	private String recDetailAddr;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate hopeDeliDate;
	private String request;
	private int price;
	private String payment;
	private int deliFee;
	private String deliState;
	private String userId;
	private int flowerNum;
}
