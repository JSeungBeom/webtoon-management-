package beans;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.http.Part;


public class MyMultiPart {
	private Map<String, MyPart> fileMap;
	
	public MyMultiPart(Collection<Part> parts, String realFolder) throws IOException {
		fileMap = new HashMap<>();
		for(Part part: parts) {
			String fileName = part.getSubmittedFileName();
			
			if(fileName != null && fileName.length() != 0) {
				String fileDotExt = fileName.substring(fileName.lastIndexOf("."), fileName.length());
				UUID uuid = UUID.randomUUID();	//UUID: 범용 고유 식별자
				String savedFileName = fileName.substring(0, fileName.lastIndexOf(".")) + "_" + uuid.toString() + fileDotExt;

				part.write(realFolder + File.separator  + savedFileName);  // 자바의 Windows 경로명 구분자는 "\\", Unix는 "/" 	
				
				MyPart mp = new MyPart(part, savedFileName);
				fileMap.put(part.getName(), mp);  //file type name속성 값을 key로 설정
				
				part.delete();
			}
		}  // end-of-for
	}
	
	public MyPart getMyPart(String paramName) { 
		return fileMap.get(paramName);			//클라이언트에서 전송받은 파일이 없으면, null 반환
	}
	
	public String getSavedFileName(String paramName) {
		return fileMap.get(paramName).getSavedFileName();
//		return this.getMyPart(paramName).getSavedFileName();	// 정의된 getMypart() 사용 방법
	}

	//HashMap에서 file type name 파라미터 값을 key로하는 value값(MyPart)을 알아낸 후, 변경전 파일명 반환
	public String getOriginalFileName(String paramName) {
		return this.getMyPart(paramName).getPart().getSubmittedFileName();
//		return fileMap.get(paramName).getPart().getSubmittedFileName();   // 정의된 getMypart() 사용 방법
	}
}
