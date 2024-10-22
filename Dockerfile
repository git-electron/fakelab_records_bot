# Use latest stable channel SDK.
FROM dart:3.4.1 AS sdk

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
COPY slang.* ./
RUN dart pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart run slang

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .

RUN dart compile exe lib/fakelab_records_bot.dart -o lib/

# Build minimal serving image from AOT-compiled `/fakelab_records_bot`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=sdk /runtime/ /
COPY --from=sdk /app/lib/

# Start server.
EXPOSE 8080
CMD ["/app/lib/fakelab_records_bot"]
