/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ITreeNode;
import dynamic.web.model.ManagedBaseModel;
import dynamic.web.model.TreeNodeSupport;
import dynamic.web.resource.Constants;

public class CategoryModel extends ManagedBaseModel implements ITreeNode{
	
	/**
	 * nodePath 는 카테고리의 트리구조를 구성하는 중요한 정보이다.
	 * nodPath 의 구조는 parent.getNodePath() + parent.getId() + "|" 로 이뤄지며
	 * parent 에 대한 정보만을 담고 있다.
	 */
	@DBField
	private String nodePath;
	
	@DBField
	private String isRootCategory = Constants.NO;
	
	/**
	 * sortOrder 는 0부터 시작되며 같은 parent 를 가지는 카테고리의 순서를 결정한다.
	 */
	@DBField
	private Integer sortOrder;
	
	@DBField
	private Integer parentId;
	
	@DBField
	private Integer relatedId;
	
	@DBField
	private Integer relatedSubId;
	
	@DBField
	private String relatedType;
	
	@DBField
	private String description;
	
	private TreeNodeSupport nodeSupport = new TreeNodeSupport();
	
	public void setName( String name){
		super.setName( name);
		setNodeName( name);
	}
	
	public String getNodePath() {
		return nodePath;
	}

	public void setNodePath(String nodePath) {
		this.nodePath = nodePath;
	}

	public String getIsRootCategory() {
		return isRootCategory;
	}

	public void setIsRootCategory(String isRootCategory) {
		this.isRootCategory = isRootCategory;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Override
	public void setNodeName(String name) {
		nodeSupport.setNodeName( name);
	}

	@Override
	public String getNodeName() {
		return nodeSupport.getNodeName();
	}

	@Override
	public void setParent(ITreeNode parent) {
		nodeSupport.setParent( parent);
	}

	@Override
	public ITreeNode getParent() {
		return nodeSupport.getParent();
	}

	@Override
	public List<ITreeNode> getChildren() {
		return nodeSupport.getChildren();
	}

	@Override
	public void addChild(ITreeNode child) {
		nodeSupport.addChild( child);
	}

	@Override
	public ITreeNode getChildById(int id) {
		return nodeSupport.getChildById( id);
	}

	@Override
	public boolean hasChild(ITreeNode child) {
		return nodeSupport.hasChild( child);
	}

	@Override
	public void removeChild(ITreeNode child) {
		nodeSupport.removeChild( child);
	}

	@Override
	public void removeChildAll() {
		nodeSupport.removeChildAll();
	}

	@Override
	public boolean hasParent() {
		return nodeSupport.hasParent();
	}

	@Override
	public ITreeNode getRoot() {
		return nodeSupport.getRoot();
	}

	@Override
	public boolean isRootNode() {
		return nodeSupport.isRootNode();
	}

	@Override
	public void setRoot(ITreeNode root) {
		nodeSupport.setRoot( root);
	}

	@Override
	public void setDepth(int depth) {
		nodeSupport.setDepth( depth);
	}

	@Override
	public int getDepth() {
		return nodeSupport.getDepth();
	}
	
	public Integer getRelatedId() {
		return relatedId;
	}

	public void setRelatedId(Integer relatedId) {
		this.relatedId = relatedId;
	}

	public Integer getRelatedSubId() {
		return relatedSubId;
	}

	public void setRelatedSubId(Integer relatedSubId) {
		this.relatedSubId = relatedSubId;
	}

	public String getRelatedType() {
		return relatedType;
	}

	public void setRelatedType(String relatedType) {
		this.relatedType = relatedType;
	}
	
	public String getJsonString(){
		JSONObject json = new JSONObject();
		json.put( "data", getName());
		
		JSONObject attrJson = new JSONObject();
		attrJson.put( "id", getId());
		attrJson.put( "rel", "root");
		json.put("attr", attrJson);
		
		JSONObject metaJson = new JSONObject();
		metaJson.put( "relatedId", getRelatedId());
		metaJson.put( "relatedSubId", getRelatedSubId());
		metaJson.put( "relatedType", getRelatedType());
		json.put( "metadata", metaJson);
		
		if( getChildren() != null){
			createJsonRecursive( getChildren(), json);
		}
		
		System.out.println( json.toJSONString());
		
		return json.toJSONString();
	}
	
	protected void createJsonRecursive( List<ITreeNode> children, JSONObject parent){
		if( children != null){
			JSONArray jsonArray = new JSONArray();
			for( ITreeNode node : children){
				CategoryModel category = (CategoryModel)node;
				JSONObject json = new JSONObject();
				
				json.put( "data", category.getName());
				JSONObject attrJson = new JSONObject();
				attrJson.put( "id", category.getId());
				json.put( "attr", attrJson);
				
				JSONObject metaJson = new JSONObject();
				metaJson.put( "relatedId", category.getRelatedId());
				metaJson.put( "relatedSubId", category.getRelatedSubId());
				metaJson.put( "relatedType", category.getRelatedType());
				json.put( "metadata", metaJson);
				
				if( category.getChildren() != null){
					createJsonRecursive( category.getChildren(), json);
				}
				
				jsonArray.add( json);
			}
			
			parent.put( "children", jsonArray);
		}
	}
	
	public static CategoryModel chainByNodePath( List<? extends ITreeNode> list){
		Map<String, ITreeNode> temp = new HashMap<String, ITreeNode>();
		for( ITreeNode node : list){
			temp.put( String.valueOf( node.getId()), node);
		}
		
		CategoryModel root = null;
		for( ITreeNode node : list){
			String[] paths = StringUtils.split( node.getNodePath(), ITreeNode.DEL_TREEINFO);
			System.out.println( node.getNodePath() + " : " + paths.length);
			node.setDepth( paths.length - 1);
			
			if( node.getDepth() == 0){
				root = (CategoryModel)node;
				continue;
			}
			
			ITreeNode parent = null;
			if( paths != null && node.getDepth() > 0){
				String parentId = paths[ node.getDepth()];
				parent = temp.get( parentId);
				parent.addChild( node);
			}
		}
		
		return root;
	}
	
	public static String genNodePath( CategoryModel parent){
		return parent.getNodePath() + parent.getId() + "|";
	}
}
