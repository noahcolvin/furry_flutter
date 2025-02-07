import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:furry_flutter/features/my_friends/data/my_friends.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend_list.dart';
import 'package:furry_flutter/shared/data/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  ProviderContainer makeProviderContainer(MockDio dio) {
    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(dio),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('fetchMyFriends calls API', () async {
    final expected = MyFriendList(friends: [
      MyFriend(
        name: 'friend1',
        image: 'image1',
      ),
      MyFriend(
        name: 'friend2',
        image: 'image2',
      ),
    ]);

    final dio = MockDio();
    when(() => dio.getUri(Uri(path: '/my-friends'), cancelToken: any(named: 'cancelToken')))
        .thenAnswer((_) async => Response(data: [
              {
                "name": 'friend1',
                "image": 'image1',
              },
              {
                "name": 'friend2',
                "image": 'image2',
              }
            ], statusCode: 200, requestOptions: RequestOptions()));

    final container = makeProviderContainer(dio);
    final result = await container.read(fetchMyFriendsProvider.future);
    expect(result, expected);
  });
}
