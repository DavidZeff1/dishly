"use client";
import Link from "next/link";
import Image from "next/image";
import { useState } from "react";
import { Menu, Pencil, LogIn, Logs, UserPen } from "lucide-react";

export default function Home() {
  const [isMenuClicked, setIsMenuClicked] = useState(false);
  return (
    <>
      <div className="bg-gray-200 h-48 flex justify-evenly items-center gap-5 border-b-2 border-gray-300 shadow">
        <Link href="/" className="hidden sm:block">
          <Image
            src={"/logos/logo.png"}
            alt={"Logo Image"}
            width={100}
            height={100}
            className="object-fit"
          />
        </Link>

        <form className="h-fit w-1/4" action="/cities" method="GET">
          <input
            className="bg-white border-2 border-gray-300 shadow rounded-xl h-8 p-4 w-full"
            placeholder="Search City"
            type="search"
          />
        </form>

        <div className="hidden md:flex justify-center gap-30 w-fit">
          <Link
            className="bg-white border-2 border-gray-300 shadow rounded-xl hover:bg-gray-100 text-center p-2 flex justify-evenly gap-2"
            href={"/profile"}
          >
            Profile
            <UserPen />
          </Link>
          <Link
            className="bg-white border-2 border-gray-300 shadow rounded-xl hover:bg-gray-100 text-center p-2 flex justify-evenly gap-2"
            href={"/register"}
          >
            Register
            <Pencil />
          </Link>
        </div>
        <button className="bg-green-100 p-2 border-2 border-gray-300 shadow rounded-full hover:cursor-pointer hover:bg-green-200">
          <LogIn></LogIn>
        </button>
        <div className="relative md:hidden">
          <button
            onClick={() => setIsMenuClicked(!isMenuClicked)}
            className="bg-white p-2 rounded-full hover:cursor-pointer hover:bg-gray-100"
          >
            {isMenuClicked ? <Logs></Logs> : <Menu></Menu>}
          </button>
          {isMenuClicked && (
            <div className="absolute -left-5  w-fit h-fit bg-white p-2 rounded-lg flex flex-col mt-2 border-2 border-gray-100 shadow">
              <Link
                className="border-b-2 border-gray-100 rounded-lg hover:bg-gray-100 text-center"
                href={"/profile"}
              >
                profile
              </Link>
              <Link
                className="border-b-2 border-gray-100 rounded-lg hover:bg-gray-100 text-center"
                href={"/register"}
              >
                register
              </Link>
            </div>
          )}
        </div>
      </div>
    </>
  );
}
