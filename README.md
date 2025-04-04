# Instagram Stories-like feature

This app has the main features:

- **Story List Screen**
    - Display a list of stories (pagination required: infinite number of stories, even if the data repeats). The rest of the screen doesn’t matter, it can be blank.
    - Each story should be visually identifiable as **seen or unseen**.
- **Story View Screen**
    - Users can navigate between the story list and individual stories.
    - Stories should have a **like/unlike** functionality.
    - Get inspired by Instagram (gestures, buttons, etc.).
- **States**
    - The user can like a story. **Seen/unseen states** should be explicit.
 - **Persistence**
    - The states should **persist across app sessions**.

The project was created mainting the MVVM, Solid and Clean principles. We have layers that have different responsibilities and were created always keeping in mind the performance, efficiency and scalability. 