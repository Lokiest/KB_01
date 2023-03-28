package ex0328.map;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class HashMapExam { //p.528
	
	Map<Integer, String> map = new HashMap<>();
//	Map<Integer, String> map = new TreeMap<>(); //sort
	
	//map의 key는 순서를 보장하지않음
	//한쌍 : Entry
	
	public HashMapExam() {
		//add
		map.put(10, "park");
		map.put(50, "choi");
		map.put(40, "Kim");
		map.put(10, "Lee"); //덮어쓰기
		map.put(20, "Hwang");
		map.put(30, "Kang");
		
		System.out.println(" size : " + map.size());
		System.out.println(map);
		
		map.remove(30);
		System.out.println(" size : " + map.size());
		System.out.println(map);
		
		System.out.println(" 조회 하기 ");
		//모든 key의 정보를 가져오기
		Set<Integer> ks = map.keySet();
		Iterator<Integer> it = ks.iterator();
//		map.get(map);
		while(it.hasNext()) {
			int key = it.next();
			String value = map.get(key);
			System.out.println(key + " = " + value);
		}
		
		System.out.println(" 개선된 for문 ");
		for(Integer its : map.keySet()) {
			String value = map.get(its);
			System.out.println(its + " = " + value);
		}
		
		System.out.println("\n Map.Entry<K,v> ");
		Set<Map.Entry<Integer, String>> set = map.entrySet();
		Iterator<Map.Entry<Integer, String>> iter = set.iterator();
		while(iter.hasNext()) {
			Map.Entry<Integer, String> entry = iter.next();
			System.out.println(entry.getKey() + " = " + entry.getValue());
		}
		
		
	}
	
	public static void main(String[] args) {
		
		new HashMapExam();

	}

}
