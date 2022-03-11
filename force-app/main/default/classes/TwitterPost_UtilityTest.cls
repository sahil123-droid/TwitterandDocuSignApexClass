@isTest
private class TwitterPost_UtilityTest {
    static testmethod void checkLogin(){
        List<String> lst = TwitterPost_Utility.login();
        System.assertEquals('Invalid', lst[0]);
        TwitterPost_Utility.storeCredentials('boepKJUbtOUD3sMmYtDp5tGTg', 'rRuS8CuSxCpyEKRVFY4TPQ3JdyHbPGfDZb1LDvfDmJ6Gns84Dd', '1405098270083354624-1pxe2uv6xezutrSYjDjSDIbupSmG5T', '3zJ2rfLK2W1AAxdfnrf78qFgIMk4EZbAlBXphcxo2sJcA');
		List<String> lst1 = TwitterPost_Utility.login();
        System.assertEquals(4, lst1.size());
    }
    static testmethod void testGetTimeline(){
        Test.setMock(HttpCalloutMock.class, new TwitterPost_UtilityMock());
        Test.startTest();
        List<Object> res =  TwitterPost_Utility.getTimeline('boepKJUbtOUD3sMmYtDp5tGTg','rRuS8CuSxCpyEKRVFY4TPQ3JdyHbPGfDZb1LDvfDmJ6Gns84Dd','1405098270083354624-1pxe2uv6xezutrSYjDjSDIbupSmG5T','3zJ2rfLK2W1AAxdfnrf78qFgIMk4EZbAlBXphcxo2sJcA');
        Test.stopTest();
        System.assertEquals(true, res!=null);
    }
    static testmethod void testLikedTweets(){
        Test.setMock(HttpCalloutMock.class, new TwitterPost_UtilityMock());
        Test.startTest();
        Map<String,Object> res =  TwitterPost_Utility.getLikedTweets('1405098270083354624','boepKJUbtOUD3sMmYtDp5tGTg','rRuS8CuSxCpyEKRVFY4TPQ3JdyHbPGfDZb1LDvfDmJ6Gns84Dd');
        Test.stopTest();
        System.assertEquals(true, res!=null);
    }
    static testmethod void testLikeTweet(){
        Test.setMock(HttpCalloutMock.class, new TwitterPost_UtilityMock());
        Test.startTest();
        Map<String,Object> res =  TwitterPost_Utility.likePost('1410795391063298053','1405098270083354624','boepKJUbtOUD3sMmYtDp5tGTg','rRuS8CuSxCpyEKRVFY4TPQ3JdyHbPGfDZb1LDvfDmJ6Gns84Dd','1405098270083354624-1pxe2uv6xezutrSYjDjSDIbupSmG5T','3zJ2rfLK2W1AAxdfnrf78qFgIMk4EZbAlBXphcxo2sJcA');
        Test.stopTest();
        System.assertEquals(true, res!=null);
    }
    static testmethod void testPostTweet(){
        Test.setMock(HttpCalloutMock.class, new TwitterPost_UtilityMock());
        Test.startTest();
        Map<String,Object> res =  TwitterPost_Utility.twitterPost('boepKJUbtOUD3sMmYtDp5tGTg','rRuS8CuSxCpyEKRVFY4TPQ3JdyHbPGfDZb1LDvfDmJ6Gns84Dd','1405098270083354624-1pxe2uv6xezutrSYjDjSDIbupSmG5T','3zJ2rfLK2W1AAxdfnrf78qFgIMk4EZbAlBXphcxo2sJcA','hello');
        Test.stopTest();
        System.assertEquals(true, res!=null);
    }
}