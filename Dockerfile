# Use latest stable channel SDK.
FROM dart:3.4.1 AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart run slang

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .

RUN dart compile exe bin/fakelab_records_bot.dart -o bin/fakelab_records_bot

# Build minimal serving image from AOT-compiled `/fakelab_records_bot`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/fakelab_records_bot /app/bin/ /app/lib/

# Start server.
EXPOSE 8080
CMD ["/app/bin/fakelab_records_bot"]
