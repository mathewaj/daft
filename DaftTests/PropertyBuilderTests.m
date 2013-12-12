//
//  PropertyBuilderTests.m
//  Daft
//
//  Created by Alan on 12/12/2013.
//  Copyright (c) 2013 Alan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PropertyBuilder.h"
#import "ErrorCodes.h"
#import "Property.h"

@interface PropertyBuilderTests : XCTestCase

@end

@implementation PropertyBuilderTests {
    
    PropertyBuilder *builder;
    
}

static NSString *daftJSONSample = @"{"
@"\"result\":"
@"{"
@"\"results\":"
@"{"
@"\"search_sentence\":\"properties for sale anywhere in Ireland entered by Baxter\","
@"\"pagination\":"
@"{"
@"\"total_results\":2,"
@"\"results_per_page\":10,"
@"\"num_pages\":1,"
@"\"current_page\":1,"
@"\"first_on_page\":1,"
@"\"last_on_page\":2"
@"}"
@","
@"\"ads\":["
@"{"
@"\"ad_id\":568996,"
@"\"daft_url\":\"http:\/\/www.daft.ie\/1568996\","
@"\"property_type\":\"house\","
@"\"house_type\":\"semi-detached\","
@"\"selling_type\":\"private-treaty\","
@"\"price_type\":\"\","
@"\"agreed\":0,"
@"\"priority\":2,"
@"\"description\":\"Modern 4 bed semi detached property\","
@"\"price\":255000,"
@"\"bedrooms\":4,"
@"\"bathrooms\":1,"
@"\"tax_section\":\"0\","
@"\"square_metres\":0,"
@"\"acres\":0,"
@"\"ber_rating\":\"D2\","
@"\"ber_code\":\"\","
@"\"ber_epi\":0,"
@"\"address\":\"32 Lohunda Crescent\","
@"\"full_address\":\"32 Lohunda Crescent, Clonsilla, Dublin 15\","
@"\"area\":\"Clonsilla\","
@"\"county\":\"Co. Dublin\","
@"\"city\":\"Dublin City\","
@"\"general_area\":\"West Co. Dublin\","
@"\"postcode\":\"Dublin 15\","
@"\"latitude\":53.388107,"
@"\"longitude\":-6.407735,"
@"\"latlon_accuracy\":1,"
@"\"agency_name\":\"Baxter\","
@"\"contact_name\":\"Marie Baxter\","
@"\"phone1\":\"01 8213733\","
@"\"phone2\":\"087 6126755\","
@"\"phoneinfo\":\"9-7 Mon - Fri 10 - 2 Sat\","
@"\"main_email\":\"sales-rbazpen@replies.daft.ie\","
@"\"cc_email\":\"sales@baxter.ie\","
@"\"auction_address\":\"\","
@"\"start_date\":1290615423,"
@"\"listing_date\":1365089199,"
@"\"agreed_date\":0,"
@"\"auction_date\":0,"
@"\"small_thumbnail_url\":\"http:\/\/m0.dmlimg.com\/ZjY3YjQ5NGY5ZjQyZWZjYTIxMGI1YjkyMTRjMzlkNmImoLZBy5vL8y62vHxVqE8haHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHx8fDEwMHx8fHx8.jpg\","
@"\"medium_thumbnail_url\":\"http:\/\/m1.dmlimg.com\/OGU3M2U1OGExZTcwYTQzZDQ1ODA5NTM1NDIwMWQzNDTQgXr0ygief5RTlAPc9kvtaHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHwxNjB8fHx8fHx8.jpg\","
@"\"large_thumbnail_url\":\"http:\/\/m0.dmlimg.com\/ZTViN2QwMmEwNDI2ZThhZWJjMWNjZDM4MDE3ODA5YTL1-xPQ8tXQzw4op1uwgsozaHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHwyNTB8fHx8fHx8.jpg\","
@"\"ipad_search_url\":\"http:\/\/m1.dmlimg.com\/ODUxNzJmOTFlOTYwZTFmM2RlMzNiNjk2ZTdkNGFkODS2R18jmPnY1GmgwKe_LkmqaHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHx8fHwxNjB4MTIwfHx8fA==.jpg\","
@"\"ipad_gallery_url\":\"http:\/\/m1.dmlimg.com\/MmI5MDA0ZmE5YThiNjJkYTY2OGE0NDk4MWU5ZjMxNzWAmffoIjyjqz4q4VvVnUKIaHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHx8fHwzNDB4MjU1fHx8fA==.jpg\","
@"\"tags\":1"
@"}"
@","
@"{"
@"\"ad_id\":714606,"
@"\"daft_url\":\"http:\/\/www.daft.ie\/1714606\","
@"\"property_type\":\"house\","
@"\"house_type\":\"detached\","
@"\"selling_type\":\"private-treaty\","
@"\"price_type\":\"\","
@"\"agreed\":0,"
@"\"priority\":2,"
@"\"description\":\"Superb Opportunity to Acquire This Modern Built 3 Bedroom DETACHED 3 Bath Family Home. This Excellent Property\","
@"\"price\":339950,"
@"\"bedrooms\":3,"
@"\"bathrooms\":4,"
@"\"tax_section\":\"0\","
@"\"square_metres\":115.23,"
@"\"acres\":0,"
@"\"ber_rating\":\"D1\","
@"\"ber_code\":\"\","
@"\"ber_epi\":0,"
@"\"address\":\"167a Clonsilla Road\","
@"\"full_address\":\"167a Clonsilla Road, Blanchardstown, Dublin 15\","
@"\"area\":\"Blanchardstown\","
@"\"county\":\"Co. Dublin\","
@"\"city\":\"Dublin City\","
@"\"general_area\":\"West Co. Dublin\","
@"\"postcode\":\"Dublin 15\","
@"\"latitude\":53.384621846,"
@"\"longitude\":-6.389309749,"
@"\"latlon_accuracy\":1,"
@"\"agency_name\":\"Baxter\","
@"\"contact_name\":\"Sales Department\","
@"\"phone1\":\"01 8213733\","
@"\"phone2\":\"\","
@"\"phoneinfo\":\"9-8 Mon - Fri 10 -6 Sat\","
@"\"main_email\":\"sales-rkizwey@replies.daft.ie\","
@"\"cc_email\":\"sales@baxter.ie\","
@"\"auction_address\":\"\","
@"\"start_date\":1367508542,"
@"\"listing_date\":1367508542,"
@"\"agreed_date\":0,"
@"\"auction_date\":0,"
@"\"small_thumbnail_url\":\"http:\/\/m0.dmlimg.com\/Zjc5YzZhMGNiOTNhMDdlMWVhYjdkYjFmMGUzYTdhMTJw3KJTT7zJ34U2ectfWxkZaHR0cDovL21lZGlhLmRhZnQuaWUvMTY3YS1DbG9uc2lsbGEtUm9hZC1CbGFuY2hhcmRzdG93bi1EdWJsaW4tMTUvMGg5a0wtNDEzNFNJWUY1azkzLTZkUi1CUUtVWmpIOUVsVHNpdXRvMzlWWnRQV1JoWm5RbWJEMDRNREE9LmpwZ3x8fHx8MTAwfHx8fHw=.jpg\","
@"\"medium_thumbnail_url\":\"http:\/\/m0.dmlimg.com\/ZTA1MzQ5ZmQ5NjY4MmQ3Y2M2NzdiZDU1MmNjMWE0ODTwUN4hoxu6sTw5se9Xq6P6aHR0cDovL21lZGlhLmRhZnQuaWUvMTY3YS1DbG9uc2lsbGEtUm9hZC1CbGFuY2hhcmRzdG93bi1EdWJsaW4tMTUvMGg5a0wtNDEzNFNJWUY1azkzLTZkUi1CUUtVWmpIOUVsVHNpdXRvMzlWWnRQV1JoWm5RbWJEMDRNREE9LmpwZ3x8fDE2MHx8fHx8fHw=.jpg\","
@"\"large_thumbnail_url\":\"http:\/\/m1.dmlimg.com\/M2E5ZTE5MDEzYTU2MmM3YTYzMTBjMmJkZWFlNjk3OGYx96p3Wg8KvKIsJvf4g5jWaHR0cDovL21lZGlhLmRhZnQuaWUvMTY3YS1DbG9uc2lsbGEtUm9hZC1CbGFuY2hhcmRzdG93bi1EdWJsaW4tMTUvMGg5a0wtNDEzNFNJWUY1azkzLTZkUi1CUUtVWmpIOUVsVHNpdXRvMzlWWnRQV1JoWm5RbWJEMDRNREE9LmpwZ3x8fDI1MHx8fHx8fHw=.jpg\","
@"\"ipad_search_url\":\"http:\/\/m1.dmlimg.com\/MzZkMDYzNTllZTlkNzRkZTJhY2NkMTI3ODMyMGM2YzibckjrG3APyVC8Gf_8EwuGaHR0cDovL21lZGlhLmRhZnQuaWUvMTY3YS1DbG9uc2lsbGEtUm9hZC1CbGFuY2hhcmRzdG93bi1EdWJsaW4tMTUvMGg5a0wtNDEzNFNJWUY1azkzLTZkUi1CUUtVWmpIOUVsVHNpdXRvMzlWWnRQV1JoWm5RbWJEMDRNREE9LmpwZ3x8fHx8fDE2MHgxMjB8fHx8.jpg\","
@"\"ipad_gallery_url\":\"http:\/\/m0.dmlimg.com\/NDNlMzBhYTA0MTRlYjk5MmZiODVhMzgwNDJlOGEwZmMi9jE7ID-SnA7201HZz-UqaHR0cDovL21lZGlhLmRhZnQuaWUvMTY3YS1DbG9uc2lsbGEtUm9hZC1CbGFuY2hhcmRzdG93bi1EdWJsaW4tMTUvMGg5a0wtNDEzNFNJWUY1azkzLTZkUi1CUUtVWmpIOUVsVHNpdXRvMzlWWnRQV1JoWm5RbWJEMDRNREE9LmpwZ3x8fHx8fDM0MHgyNTV8fHx8.jpg\","
@"\"tags\":1"
@"}"
@"]"
@"}"
@"}"
@","
@"\"faultcode\":null,"
@"\"faultstring\":\"\""
@"}";

- (void)setUp
{
    [super setUp];
    builder = [[PropertyBuilder alloc] init];
}

- (void)tearDown
{
    builder = nil;
    [super tearDown];
}

-(void)testThatNullsAcceptableErrorParamter{
    
    XCTAssertNoThrow([builder propertiesFromJSON:@"Not JSON" error:NULL], @"Using NULL for error should not be a problem");
    
}

-(void)testThatNilIsUnacceptableJSONParameter{
    
    XCTAssertThrows([builder propertiesFromJSON:nil error:NULL], @"Lack of JSON data should have been processed elsewhere");
}

-(void)testThatFaultyJSONReturnsNil{
    
    XCTAssertNil([builder propertiesFromJSON:@"Not JSON" error:NULL], @"Non-JSON parameter should not be parsable");
    
}

-(void)testThatFaultyJSONSetsError{
    
    NSError *error = nil;
    [builder propertiesFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"Non-JSON parameter should set error");
    
}

-(void)testRealJSONWithoutPropertiesArrayReturnsMissingDataError{
    
    NSString *jsonString = @"{\"nopropertieshere\": true }";
    NSError *error = nil;
    [builder propertiesFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], PropertyBuilderErrorDomainMissingDataError, @"Builder should detect that no properties array in JSON");
    
    
}


-(void)testThatTwoJSONPropertiesSuccessfullyCreatedFromSampleJSON{
    
    NSError *error = nil;
    NSArray * properties = [builder propertiesFromJSON:daftJSONSample error:&error];
    XCTAssertEqual([properties count], (NSUInteger)2, @"The builder should have created two property objects from the sample JSON");
}

-(void)testThatPropertyCreatedFromJSONHasSamePropertiesAsJSONObjects{
    
    NSError *error = nil;
    NSArray *properties = [builder propertiesFromJSON:daftJSONSample error:&error];
    Property *property = [properties objectAtIndex:0];
    
    NSLog(@"%@",property.fullAddress);
    
    XCTAssertTrue([property.fullAddress isEqualToString:@"32 Lohunda Crescent, Clonsilla, Dublin 15"], @"Property address should match JSON");
    XCTAssertTrue([property.imageURL isEqualToString:@"http:\/\/m0.dmlimg.com\/ZjY3YjQ5NGY5ZjQyZWZjYTIxMGI1YjkyMTRjMzlkNmImoLZBy5vL8y62vHxVqE8haHR0cDovL21lZGlhLmRhZnQuaWUvMzItTG9odW5kYS1DcmVzY2VudC1DbG9uc2lsbGEtRHVibGluLTE1L0RoaGFaMk1KV0VTQW8zWmJDUk5PTlM0aGhDdWJTaHRpZ0FUalJWUUc2b0J0UFdSaFpuUW1iRDA0TURBPS5qcGd8fHx8fDEwMHx8fHx8.jpg"], @"Property image URL should match JSON");
    
    
}




@end
