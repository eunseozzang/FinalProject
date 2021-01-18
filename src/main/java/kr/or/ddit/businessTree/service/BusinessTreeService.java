package kr.or.ddit.businessTree.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.businessTree.dao.BusinessTreeMapperDao;
import kr.or.ddit.businessTree.vo.BusinessTreeVO;

@Service("businessTreeService")
public class BusinessTreeService {
	
	@Resource(name = "businessTreeMapperDao")
	private BusinessTreeMapperDao businessTreeMapperDao;

	
	
	public List<BusinessTreeVO> selectBusinessTreeList(BusinessTreeVO busiTree) throws Exception {
		return businessTreeMapperDao.selectBusinessTreeList(busiTree);
	}

}
