package me.justshare.service;

import me.justshare.domain.SharedItem;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 17, 2010
 */
public class Cache {

    private static final Cache _instance = new Cache();

    Map<String, Entry> itemsMap = Collections.synchronizedMap(new WeakHashMap<String, Entry>());

    private static final int EXPIRATION = 10 * 60 * 1000;

    private Cache() {
        
    }

    public static Cache getInstance() {
        return _instance;
    }

    public void storeItems(String space, int page, List<SharedItem> items) {
        itemsMap.put(itemsCacheKey(space, page), new Entry(items));
    }

    private String itemsCacheKey(String space, int page) {
        return space+":::"+page;
    }

    public boolean hasItemsFor(String space, int page) {
        String key = itemsCacheKey(space, page);
        if (!itemsMap.containsKey(key))
            return false;
        else {
            Entry e = itemsMap.get(key);
            if (System.currentTimeMillis() - e.timestamp > EXPIRATION)
            {
                itemsMap.remove(key);
                return false;
            }
            else
            {
                return true;
            }
        }
    }

    public List<SharedItem> getItemsFor(String space, int page) {
        String key = itemsCacheKey(space, page);
        return (List<SharedItem>) itemsMap.get(key).obj;
    }

    public void invalidateItemsFor(String space) {
        for (int page = 0 ; page < 10; page++)
        {
            String key = itemsCacheKey(space, page);
            if (itemsMap.containsKey(key))
                itemsMap.remove(key);
        }
    }
    

    
}

class Entry {
    public Object obj;
    public long timestamp;

    public Entry(Object o) {
        this.obj = o;
        this.timestamp = System.currentTimeMillis();
    }
}
