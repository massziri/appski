import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/promo/promo_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/common/main_shell.dart';
import '../screens/home/home_screen.dart';
import '../screens/discover/discover_screen.dart';
import '../screens/discover/businesses/business_list_screen.dart';
import '../screens/discover/businesses/business_detail_screen.dart';
import '../screens/discover/organisations/organisation_list_screen.dart';
import '../screens/discover/organisations/organisation_detail_screen.dart';
import '../screens/discover/recipes/recipe_hub_screen.dart';
import '../screens/discover/recipes/recipe_detail_screen.dart';
import '../screens/discover/tourism/tourism_hub_screen.dart';
import '../screens/discover/tourism/tourism_detail_screen.dart';
import '../screens/events/events_screen.dart';
import '../screens/events/event_detail_screen.dart';
import '../screens/events/events_calendar_screen.dart';
import '../screens/events/past_events_screen.dart';
import '../screens/media/media_screen.dart';
import '../screens/media/radio/radio_list_screen.dart';
import '../screens/media/radio/radio_player_screen.dart';
import '../screens/media/tv/tv_screen.dart';
import '../screens/media/news/news_list_screen.dart';
import '../screens/media/news/news_detail_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/more/calendar/orthodox_calendar_screen.dart';
import '../screens/more/calendar/calendar_day_detail_screen.dart';
import '../screens/more/calendar/nameday_lookup_screen.dart';
import '../screens/more/weather/weather_screen.dart';
import '../screens/more/settings/settings_screen.dart';
import '../screens/more/about/about_screen.dart';
import '../screens/more/submit/submit_screen.dart';
import '../screens/more/contact/contact_screen.dart';
import '../screens/more/admin/admin_panel_screen.dart';
import '../screens/common/search_screen.dart';
import '../screens/common/notifications_screen.dart';
import '../screens/common/webview_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/promo',
      builder: (context, state) => const PromoScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/search',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/notifications',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/webview',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>? ?? {};
        return WebViewScreen(
          title: extra['title'] ?? 'Web',
          url: extra['url'] ?? '',
        );
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/discover',
          pageBuilder: (context, state) => const NoTransitionPage(child: DiscoverScreen()),
          routes: [
            GoRoute(
              path: 'businesses',
              builder: (context, state) => const BusinessListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => BusinessDetailScreen(businessId: state.pathParameters['id']!),
                ),
              ],
            ),
            GoRoute(
              path: 'organisations',
              builder: (context, state) => const OrganisationListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => OrganisationDetailScreen(organisationId: state.pathParameters['id']!),
                ),
              ],
            ),
            GoRoute(
              path: 'recipes',
              builder: (context, state) => const RecipeHubScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => RecipeDetailScreen(recipeId: state.pathParameters['id']!),
                ),
              ],
            ),
            GoRoute(
              path: 'tourism',
              builder: (context, state) => const TourismHubScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => TourismDetailScreen(placeId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/events',
          pageBuilder: (context, state) => const NoTransitionPage(child: EventsScreen()),
          routes: [
            GoRoute(
              path: 'calendar',
              builder: (context, state) => const EventsCalendarScreen(),
            ),
            GoRoute(
              path: 'past',
              builder: (context, state) => const PastEventsScreen(),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) => EventDetailScreen(eventId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/media',
          pageBuilder: (context, state) => const NoTransitionPage(child: MediaScreen()),
          routes: [
            GoRoute(
              path: 'radio',
              builder: (context, state) => const RadioListScreen(),
              routes: [
                GoRoute(
                  path: 'player',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final extra = state.extra as Map<String, String>? ?? {};
                    return RadioPlayerScreen(stationId: extra['stationId'] ?? '');
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'tv',
              builder: (context, state) => const TvScreen(),
            ),
            GoRoute(
              path: 'news',
              builder: (context, state) => const NewsListScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => NewsDetailScreen(newsId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/more',
          pageBuilder: (context, state) => const NoTransitionPage(child: MoreScreen()),
          routes: [
            GoRoute(
              path: 'calendar',
              builder: (context, state) => const OrthodoxCalendarScreen(),
              routes: [
                GoRoute(
                  path: 'day/:dateKey',
                  builder: (context, state) => CalendarDayDetailScreen(dateKey: state.pathParameters['dateKey']!),
                ),
                GoRoute(
                  path: 'namedays',
                  builder: (context, state) => const NameDayLookupScreen(),
                ),
              ],
            ),
            GoRoute(
              path: 'weather',
              builder: (context, state) => const WeatherScreen(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
            GoRoute(
              path: 'about',
              builder: (context, state) => const AboutScreen(),
            ),
            GoRoute(
              path: 'submit',
              builder: (context, state) => const SubmitScreen(),
            ),
            GoRoute(
              path: 'contact',
              builder: (context, state) => const ContactScreen(),
            ),
            GoRoute(
              path: 'admin',
              builder: (context, state) => const AdminPanelScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
