import time
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

city_data = { 'chicago': 'chicago.csv',
              'new york': 'new_york_city.csv',
              'washington': 'washington.csv' }

month_data = ['january','february','march','april','may','june','all']

month_data_abrev = ['jan','feb','mar','apr','may','jun']

day_data = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday','all']

day_data_abrev = ['mon','tue','wed','thu','fri','sat','sun']


def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    # introductory message
    print("")
    print('-'*40)
    print("HELLO! LET\'S EXPLORE SOME US BIKESHARE DATA!\n")
    print("Description:\nHere, you may take a look at bikeshare use in the cities of 'chicago', 'new york' and 'washington', for the months of january to june in 2017, and whithin particular days of the week. Cool, right!? Well, so let's get started!\n")

    # get user input for city (chicago, new york city, washington). HINT: Use a while loop to handle invalid inputs
    print("Which data you want to look at?")
    city = input("Enter a city name: ").lower()
    while city not in city_data:
        print("\nOPS, IT SEEMS THAT YOU ENTERED A WRONG CITY NAME!\nAvailable options are: 'chicago', 'new york' or 'washington'.\nPlease try again!\n")
        city = input("Enter a city name: ")

    # get user input for month (all, january, february, ... , june)
    month = input("Enter a month (or type 'all' for all months): ").lower()
    while month not in month_data:
        print("\nOPS, IT SEEMS THAT YOU ENTERED A WRONG MONTH!\nOnly the months of january to june are available.\nPlease try again!\n")
        month = input("Enter a month (or type 'all' for all months): ")

    # get user input for day of week (all, monday, tuesday, ... sunday)
    day = input("Enter a day of the week (or type 'all' for all days): ").lower()
    while day not in day_data:
        print("\nHMMM, IT SEEMS THAT YOU ENTERED A WRONG DAY OF THE WEEK!\nPlease try again!\n")
        day = input("Enter a day of the week (or type 'all' for all days): ")

    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """
    # load data file into a dataframe
    df = pd.read_csv(city_data[city])

    # convert the Start Time column to datetime
    df['Start Time'] = pd.to_datetime(df['Start Time'])
    df['End Time'] = pd.to_datetime(df['End Time'])

    # extract month and day of week from Start Time to create new columns
    df['month'] = df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.weekday_name

    # filter by month if applicable
    if month != 'all':
        # use the index of the months list to get the corresponding int
        month = month_data.index(month)+1
        # filter by month to create the new dataframe
        df = df[df['month'] == month]

    # filter by day of week if applicable
    if day != 'all':
        # filter by day of week to create the new dataframe
        df = df[df['day_of_week'] == day.title()]

    return df


def time_stats(df, month, day):
    """Displays statistics on the most frequent times of travel."""

    print('-'*40)
    print('\nTHE MOST FREQUENT TIMES OF TRAVEL\n')
    print('-'*40)
    start_time = time.time()

    # display the most common month
    if month == 'all':
        popular_month = month_data[(df['month'].value_counts().idxmax()-1)]
        print('Commonest month:', popular_month.title())

    # display the most common day of week
    if day == 'all':
        popular_weekday = df['day_of_week'].value_counts().idxmax()
        print('Commonest day of the week:', popular_weekday.title())

    # display the most common start hour
    df['start_hour'] = df['Start Time'].dt.hour
    popular_start_hour = df['start_hour'].value_counts().idxmax()
    print('\nMost frequent start hour: ' + str(popular_start_hour) + "h")

    # display the most common end hour
    df['end_hour'] = df['End Time'].dt.hour
    popular_end_hour = df['end_hour'].value_counts().idxmax()
    print('Most frequent end hour: ' + str(popular_end_hour) + "h")

    print("\n(calculations took %ss)" % round((time.time() - start_time),2))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trips."""

    print('-'*40)
    print('\nTHE MOST POPULAR STATIONS AND TRIPS\n')
    print('-'*40)
    start_time = time.time()

    # display most commonly used start station
    popular_start_station = df['Start Station'].value_counts().idxmax()
    print("Commonest start station: ", popular_start_station.title())

    # display most commonly used end station
    popular_end_station = df['End Station'].value_counts().idxmax()
    print("Commonest end station: ", popular_end_station.title())

    # display most frequent combination of start station and end station trip
    station_combinations = df['Start Station'] + " / " + df['End Station']
    popular_station_combination = station_combinations.value_counts().idxmax()
    print("Commonest start-end station combination: ", popular_station_combination)

    print("\n(calculations took %ss)" % round((time.time() - start_time),2))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('-'*40)
    print('\nTRIP DURATION\n')
    print('-'*40)
    start_time = time.time()

    # display total travel time
    total_travel_time = time.strftime("%H:%M:%S", time.gmtime(df['Trip Duration'].sum()))
    print("Total travel time: " + str(total_travel_time) + " (h:m:s)")

    # display mean travel time
    mean_travel_time = time.strftime("%H:%M:%S", time.gmtime(df['Trip Duration'].mean()))
    print("Mean travel time: " + str(mean_travel_time) + " (h:m:s)")

    print("\n(calculations took %ss)" % round((time.time() - start_time),2))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('-'*40)
    print('\nUSER STATISTICS\n')
    print('-'*40)
    start_time = time.time()

    # display counts and percentages of user types
    user_types = df['User Type'].value_counts()
    sum = user_types.sum()
    percentage = int()
    for name, value in user_types.items():
        percentage = round((value/sum)*100, 2)
        print("{} number: {} ({}%)".format(name, str(value), str(percentage)))
    print("")

    # display counts and percentages of gender
    if "Gender" in df:
        gender_types = df['Gender'].value_counts()
        sum = gender_types.sum()
        percentage = int()
        for name, value in gender_types.items():
            percentage = round((value/sum)*100, 2)
            print("{} users: {} ({}%)".format(name, str(value), str(percentage)))
        print("")
    elif "Gender" not in df:
        print("Gender not available for this city")

    # display earliest, most recent, and most common year of birth
    if "Birth Year" in df:
        birth_year_min = int(df['Birth Year'].min())
        birth_year_max = int(df['Birth Year'].max())
        birth_year_mod = int(df['Birth Year'].mode())
        current_year = int(time.strftime("%Y"))
        print("Earliest year of birth (user age): {} ({} years old)".format(birth_year_min, current_year-birth_year_min))
        print("Latest year of birth (user age): {} ({} years old)".format(birth_year_max, current_year-birth_year_max))
        print("Commonest year of birth (user age): {} ({} years old)".format(birth_year_mod, current_year-birth_year_mod))

    print("\n(calculations took %ss)" % round((time.time() - start_time),2))
    print('-'*40)


def graphs(df, month, day):
    """ Visualize the numerical data in 3-4 graphs in one panel using pyplot.
        Since datasets do not have always the same variables of interest,
        we need first to use an if condition to filter out the variable Gender.
    """
    # Start plotting the subplot graphs in one window
    fig = plt.figure()

    if "Gender" in df:
        if month == "all":
            # Calculate means for graphs
            mean_duration_gender = df.groupby(["Gender", "month"])["Trip Duration"].mean()
            mean_duration_user = df.groupby(["User Type", "month"])["Trip Duration"].mean()
            mean_duration = df.groupby(["month"])["Trip Duration"].mean()
            mean_start_time = df.groupby("month")["start_hour"].mean()
            mean_end_time = df.groupby(["month"])["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_women = list(mean_duration_gender.loc["Female"])
            duration_mean_men = list(mean_duration_gender.loc["Male"])
            duration_mean_customer = list(mean_duration_user.loc["Customer"])
            duration_mean_subscriber = list(mean_duration_user.loc["Subscriber"])

            # Trip duration per gender
            ax1 = fig.add_subplot(221)
            ax1.scatter([1,2,3,4,5,6], duration_mean_women, c="pink")
            ax1.scatter([1,2,3,4,5,6], duration_mean_men, c="blue")
            ax1.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax1.legend(["female","male"], loc='upper right')

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([1,2,3,4,5,6], duration_mean_customer, c="black")
            ax2.scatter([1,2,3,4,5,6], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([1,2,3,4,5,6], mean_start_time, c='green')
            ax3.scatter([1,2,3,4,5,6], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month")
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.plot([1,2,3,4,5,6], mean_duration, 'black')
            ax4.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.xlabel("Month")
            plt.ylabel("Mean trip duration (s)")

        elif month != "all" and day == "all":
            # Calculate means for graphs
            mean_duration_gender = df.groupby(["Gender", "day_of_week"])["Trip Duration"].mean()
            mean_duration_user = df.groupby(["User Type", "day_of_week"])["Trip Duration"].mean()
            mean_duration = df.groupby(["day_of_week"])["Trip Duration"].mean()
            mean_start_time = df.groupby("day_of_week")["start_hour"].mean()
            mean_end_time = df.groupby(["day_of_week"])["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_women = list(mean_duration_gender.loc["Female"])
            duration_mean_men = list(mean_duration_gender.loc["Male"])
            duration_mean_customer = list(mean_duration_user.loc["Customer"])
            duration_mean_subscriber = list(mean_duration_user.loc["Subscriber"])

            # Trip duration per gender
            ax1 = fig.add_subplot(221)
            ax1.scatter([5,1,6,7,4,2,3], duration_mean_women, c="pink")
            ax1.scatter([5,1,6,7,4,2,3], duration_mean_men, c="blue")
            ax1.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax1.legend(["female","male"], loc='upper right')

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([5,1,6,7,4,2,3], duration_mean_customer, c="black")
            ax2.scatter([5,1,6,7,4,2,3], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([5,1,6,7,4,2,3], mean_start_time, c='green')
            ax3.scatter([5,1,6,7,4,2,3], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month")
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.scatter([5,1,6,7,4,2,3], mean_duration, c='black')
            ax4.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.xlabel("Month")
            plt.ylabel("Mean trip duration (s)")

        else:
            # Calculate means for graphs
            mean_duration_gender = df.groupby("Gender")["Trip Duration"].mean()
            mean_duration_user = df.groupby("User Type")["Trip Duration"].mean()
            mean_duration = df["Trip Duration"].mean()
            mean_start_time = df["start_hour"].mean()
            mean_end_time = df["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_women = list(mean_duration_gender[0:1])
            duration_mean_men = list(mean_duration_gender[1:2])
            duration_mean_customer = list(mean_duration_user[0:1])
            duration_mean_subscriber = list(mean_duration_user[1:2])

            # Trip duration per gender
            ax1 = fig.add_subplot(221)
            ax1.scatter([1], duration_mean_women, c="pink")
            ax1.scatter([1], duration_mean_men, c="blue")
            ax1.axis(ymin=0, ymax=3000)
            plt.xlabel("")
            plt.xticks([1], "")
            plt.ylabel("Mean trip duration (s)")
            ax1.legend(["female","male"], loc='upper right')

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([1], duration_mean_customer, c="black")
            ax2.scatter([1], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xlabel("")
            plt.xticks([1], "")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([1], mean_start_time, c='green')
            ax3.scatter([1], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1], "")
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month of {}".format(month.title()))
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.scatter([1], mean_duration, c='black')
            ax4.axis(ymin=0, ymax=3000)
            plt.xticks([1], "")
            plt.xlabel("Month of {}".format(month.title()))
            plt.ylabel("Mean trip duration (s)")

    if "Gender" not in df:
        if month == "all":
            # Calculate means for graphs
            mean_duration_user = df.groupby(["User Type", "month"])["Trip Duration"].mean()
            mean_duration = df.groupby(["month"])["Trip Duration"].mean()
            mean_start_time = df.groupby("month")["start_hour"].mean()
            mean_end_time = df.groupby(["month"])["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_customer = list(mean_duration_user.loc["Customer"])
            duration_mean_subscriber = list(mean_duration_user.loc["Subscriber"])

            # Trip duration per gender

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([1,2,3,4,5,6], duration_mean_customer, c="black")
            ax2.scatter([1,2,3,4,5,6], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([1,2,3,4,5,6], mean_start_time, c='green')
            ax3.scatter([1,2,3,4,5,6], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month")
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.plot([1,2,3,4,5,6], mean_duration, 'black')
            ax4.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6], month_data_abrev)
            plt.xlabel("Month")
            plt.ylabel("Mean trip duration (s)")

        elif month != "all" and day == "all":
            # Calculate means for graphs
            mean_duration_user = df.groupby(["User Type", "day_of_week"])["Trip Duration"].mean()
            mean_duration = df.groupby(["day_of_week"])["Trip Duration"].mean()
            mean_start_time = df.groupby("day_of_week")["start_hour"].mean()
            mean_end_time = df.groupby(["day_of_week"])["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_customer = list(mean_duration_user.loc["Customer"])
            duration_mean_subscriber = list(mean_duration_user.loc["Subscriber"])

            # Trip duration per gender

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([5,1,6,7,4,2,3], duration_mean_customer, c="black")
            ax2.scatter([5,1,6,7,4,2,3], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.xlabel("")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([5,1,6,7,4,2,3], mean_start_time, c='green')
            ax3.scatter([5,1,6,7,4,2,3], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month")
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.scatter([5,1,6,7,4,2,3], mean_duration, c='black')
            ax4.axis(ymin=0, ymax=3000)
            plt.xticks([1,2,3,4,5,6,7], day_data_abrev)
            plt.xlabel("Month")
            plt.ylabel("Mean trip duration (s)")

        else:
            # Calculate means for graphs
            mean_duration_user = df.groupby("User Type")["Trip Duration"].mean()
            mean_duration = df["Trip Duration"].mean()
            mean_start_time = df["start_hour"].mean()
            mean_end_time = df["end_hour"].mean()

            # Split the data between gender (women and men) and user types
            duration_mean_customer = mean_duration_user.loc["Customer"]
            duration_mean_subscriber = mean_duration_user.loc["Subscriber"]

            # Trip duration per gender

            # Trip duration per user type
            ax2 = fig.add_subplot(222)
            ax2.scatter([1], duration_mean_customer, c="black")
            ax2.scatter([1], duration_mean_subscriber, c="red")
            ax2.axis(ymin=0, ymax=3000)
            plt.xlabel("")
            plt.xticks([1], "")
            plt.ylabel("Mean trip duration (s)")
            ax2.legend(["customer","subscriber"], loc='upper right')

            # Mean start and end times
            ax3 = fig.add_subplot(223)
            ax3.scatter([1], mean_start_time, c='green')
            ax3.scatter([1], mean_end_time, c='yellow')
            ax3.axis(ymin=0, ymax=30)
            plt.xticks([1], "")
            plt.yticks([5,10,15,20,24], ["5h","10h","15h","20h","24h"])
            plt.xlabel("Month of {}".format(month.title()))
            plt.ylabel("Mean start and end hours")
            ax3.legend(["start hour","end hour"], loc='upper right')

            # Mean trip duration
            ax4 = fig.add_subplot(224)
            ax4.bar([1], mean_duration)
            ax4.axis(xmin=0, xmax=4 ,ymin=0, ymax=3000)
            plt.xticks([1], "")
            plt.xlabel("Month of {}".format(month.title()))
            plt.ylabel("Mean trip duration (s)")

    # configure and show plot
    plt.tight_layout()
    plt.show()


def main():
    """ Main function:
        Here are steps taken for all function calls. First user data is taken
        Based on the information given by the user, the according calculations
        are performed, and then are shown in the console in combination with
        graphical representations. For each step in the calculations, the program
        asks the user to press 'enter' in order to move on to the next step.
    """
    # preliminary part: user input and data selection
    city, month, day = get_filters()
    df = load_data(city, month, day)

    # calculations
    time_stats(df, month, day)
    input("Press enter to continue...\n")
    station_stats(df)
    input("Press enter to continue...\n")
    trip_duration_stats(df)
    input("Press enter to continue...\n")
    user_stats(df)

    # data visualization
    input("Press enter to see some graphs...\n")
    graphs(df, month, day)

    # restarting or ending the program
    print('-'*40)
    print("End of analysis.\nI hope you enjoyed!")
    restart = input("\nWould you like to restart?\nPress 'yes' if so, otherwise any other action will end this program: ").lower()
    if restart.lower() == 'yes':
        main()


if __name__ == '__main__':
    main()
